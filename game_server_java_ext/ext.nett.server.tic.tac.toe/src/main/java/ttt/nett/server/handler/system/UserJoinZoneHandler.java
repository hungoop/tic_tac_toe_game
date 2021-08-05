package ttt.nett.server.handler.system;

import org.json.JSONObject;
import org.slf4j.Logger;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class UserJoinZoneHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(RoomAddedHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zon = (Zone) event.getParameter(GEventParam.ZONE);
		User user = (User) event.getParameter(GEventParam.USER);
		JSONObject jObject = (JSONObject) event.getParameter(GEventParam.LOGIN_IN_DATA);
		log.debug("zone: " + zon.getName() + " user: " + user.getName() + " json: " + jObject.toString());
		
		log.debug("=======JOIN ZONE OK=======>>>>UserName: " + user.getName());

	}

}
