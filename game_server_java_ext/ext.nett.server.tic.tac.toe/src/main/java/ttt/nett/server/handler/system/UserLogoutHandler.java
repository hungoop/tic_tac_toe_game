package ttt.nett.server.handler.system;

import java.util.List;

import org.json.JSONArray;
import org.slf4j.Logger;

import admin.nett.server.st.AdConfig;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.command.CMD;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.util.MessUtils;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class UserLogoutHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(UserLogoutHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		User user = (User) event.getParameter(GEventParam.USER);
		
		@SuppressWarnings("unchecked")
		List<Long> joinedRooms = (List<Long>) event.getParameter(GEventParam.JOINED_ROOM);
		
		log.debug(zone.getName() + " UserLogOutHandler => room:" + joinedRooms + ", user:" + user.getName());
		
		try {
			long roomID = -1;
			
			if(joinedRooms.size() > 0) {
				//roomID = joinedRooms.get(0);//user.getLastJoinedRoom();
				roomID = user.getLastJoinedRoom();
				
				Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
				
				RoomGameControler controler = TTTExtension.getGameControler(r);
				
				if(controler != null ) {
					controler.leaveGame(user);
				}
			}
			
			JSONArray dataUsers = getUserList(zone);
			this.getApi().sendToListUser(
					zone.getAllSessions(), 
					CMD.USER_LIST.getCmd(), 
					MessUtils.makeJsonData(dataUsers)
				);
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}

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
