package ttt.nett.server.handler.system;

import java.util.List;

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
public class UserDisconnectHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(UserDisconnectHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		User user = (User) event.getParameter(GEventParam.USER);
		
		@SuppressWarnings("unchecked")
		List<Long> joinedRooms = (List<Long>) event.getParameter(GEventParam.JOINED_ROOM);

		log.debug(zone.getName() + " UserDisconnectHandler => room:" + joinedRooms + ", user:" + user.getName());
		
		try {
			long roomID = joinedRooms.get(0);//user.getLastJoinedRoom();
			
			Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
			
			RoomGameControler controler = TTTExtension.getGameControler(r);
			if(controler != null ) {
				controler.disconnectGame(user);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}

	}

}
