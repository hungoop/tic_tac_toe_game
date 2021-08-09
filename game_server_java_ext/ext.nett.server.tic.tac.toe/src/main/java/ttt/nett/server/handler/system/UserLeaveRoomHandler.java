package ttt.nett.server.handler.system;

import org.slf4j.Logger;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class UserLeaveRoomHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(UserLeaveRoomHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		Room room = (Room) event.getParameter(GEventParam.ROOM);
		User user = (User) event.getParameter(GEventParam.USER);
		
		log.debug(zone.getName() + " UserLeaveRoomHandler => room:" + room.getName() + ", user:" + user.getName());
		
		try {
			RoomGameControler controler = TTTExtension.getGameControler(room);
			controler.userGiveUp(user);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		
	}

}
