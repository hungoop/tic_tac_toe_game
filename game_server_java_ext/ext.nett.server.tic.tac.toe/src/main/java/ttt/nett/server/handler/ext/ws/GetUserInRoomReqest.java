package ttt.nett.server.handler.ext.ws;

import org.json.JSONObject;
import org.slf4j.Logger;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.User;
import nett.server.st.game.extension.BaseClientRequestHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class GetUserInRoomReqest extends BaseClientRequestHandler {
	private static Logger log = LogExt.getLogApp(GetUserInRoomReqest.class);
	//private final static String ROOM_ID = "ri";

	@Override
	public void handleClientRequest(User sender, JSONObject params) {
		try {
			//long roomID = params.getLong(ROOM_ID);
			
			long roomID = sender.getLastJoinedRoom();
			
			Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
			
			/*
			JSONArray dataUsers = getUserList(r);
			this.getApi().sendToUser(
					sender, 
					CMD.USER_IN_ROOM.getCmd(), 
					MessUtils.makeJsonData(dataUsers)
				);*/
			
			RoomGameControler controler = TTTExtension.getGameControler(r);
			if(controler != null ) {
				controler.getUserList(sender);
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}

	}
	
	/*
	private JSONArray getUserList(Room room) {
		List<User> userLst = room.getUserList();
		
		JSONArray jArr = new JSONArray();
		for(User usr : userLst) {
			jArr.put(usr.toJson());
		}
		
		return jArr;
		
	}*/

}
