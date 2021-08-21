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
public class GetUserInRoomRequest extends BaseClientRequestHandler {
	private static Logger log = LogExt.getLogApp(GetUserInRoomRequest.class);
	//private static final String R_ID 		= "ri";

	@Override
	public void handleClientRequest(User sender, JSONObject params) {
		try {
			//long roomID = params.getLong(ROOM_ID);
			
			long roomID = sender.getLastJoinedRoom();
			
			Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
			
			RoomGameControler controler = TTTExtension.getGameControler(r);
			if(controler != null ) {
				controler.getUserListOfRoom(sender);
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}

	}

}
