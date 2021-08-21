package ttt.nett.server.handler.ext.ws;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;

import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.User;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseClientRequestHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.exception.InviteJoinExcetion;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class InviteFriendWSRequest extends BaseClientRequestHandler {
	private static Logger log = LogExt.getLogApp(InviteFriendWSRequest.class);
	
	private final static String ROOM_ID = "ri";
	private final static String FRIEND_LIST_ID = "fs";

	@Override
	public void handleClientRequest(User sender, JSONObject params) throws GException {
		log.debug(params.toString());
		if(params.has(ROOM_ID) && params.has(FRIEND_LIST_ID)) {
			long roomID = params.getInt(ROOM_ID);
			JSONArray fLst = params.getJSONArray(FRIEND_LIST_ID);
			
			try {
				long roomIDSever = sender.getLastJoinedRoom();
				
				if(roomID != roomIDSever) {
					throw new InviteJoinExcetion("RoomID is wrong!");
				}
				
				Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
				
				RoomGameControler controler = TTTExtension.getGameControler(r);
				if(controler != null ) {
					controler.sendInviteData(sender, fLst);
				}
				
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}

	}

}
