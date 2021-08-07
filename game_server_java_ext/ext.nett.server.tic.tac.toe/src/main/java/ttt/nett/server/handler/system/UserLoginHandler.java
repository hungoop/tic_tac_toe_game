package ttt.nett.server.handler.system;

import org.json.JSONObject;
import org.slf4j.Logger;

import nett.server.st.data.Session;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class UserLoginHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(UserLoginHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zon = (Zone) event.getParameter(GEventParam.ZONE);
		Session ses = (Session) event.getParameter(GEventParam.SESSION);
		String uName = (String) event.getParameter(GEventParam.LOGIN_NAME);
		String pass = (String) event.getParameter(GEventParam.LOGIN_PASSWORD);
		JSONObject jObject = (JSONObject) event.getParameter(GEventParam.LOGIN_IN_DATA);
		
		log.debug("zone: " + zon.getName() + " ssid: " + ses.getId() + " uName: " + uName + " pass: " + pass + " json: " + jObject.toString());

	}

}
