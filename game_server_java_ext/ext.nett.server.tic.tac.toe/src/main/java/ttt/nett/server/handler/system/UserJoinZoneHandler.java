package ttt.nett.server.handler.system;

import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import admin.nett.server.st.AdConfig;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.command.CMD;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.util.MessUtils;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class UserJoinZoneHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(UserJoinZoneHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zon = (Zone) event.getParameter(GEventParam.ZONE);
		User user = (User) event.getParameter(GEventParam.USER);
		JSONObject jObject = (JSONObject) event.getParameter(GEventParam.LOGIN_IN_DATA);
		log.debug("zone: " + zon.getName() + " user: " + user.getName() + " json: " + jObject.toString());
		
		log.debug("=======JOIN ZONE OK=======>>>>UserName: " + user.getName());
		
		JSONArray dataRooms = getRoomList(zon);
		this.getApi().sendToUser(
				user, 
				CMD.ROOM_LIST.getCmd(), 
				MessUtils.makeJsonData(dataRooms)
			);
		
		JSONArray dataUsers = getUserList(zon);
		this.getApi().sendToListUser(
				zon.getAllSessions(), 
				CMD.USER_LIST.getCmd(), 
				MessUtils.makeJsonData(dataUsers)
			);

	}
	
	private JSONArray getRoomList(Zone zone) {
		List<Room> roomLst = zone.getRoomList();
		
		JSONArray jArr = new JSONArray();
		for(Room r : roomLst) {
			jArr.put(r.toJson(AdConfig.LEVEL_ROOM));
		}
		
		return jArr;
		
	}
	
	private JSONArray getUserList(Zone zone) {
		List<User> userLst = zone.getAllUsers();
		
		JSONArray jArr = new JSONArray();
		for(User usr : userLst) {
			jArr.put(usr.toJson());
		}
		
		return jArr;
		
	}

}
