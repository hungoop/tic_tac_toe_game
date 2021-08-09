package ttt.nett.server.handler.ext.ws;

import org.json.JSONObject;
import org.slf4j.Logger;

import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.User;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseClientRequestHandler;
import nett.server.st.util.Utilities;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class PlayGameWSRequest extends BaseClientRequestHandler {
	private static Logger log = LogExt.getLogApp(PlayGameWSRequest.class);
	private static final String POS_X = "x";
	private static final String POS_Y = "y";

	@Override
	public void handleClientRequest(User sender, JSONObject params) throws GException {
		log.debug(params.toString());
		try {
			int posX = Utilities.parseInt(params.getString(POS_X));
			int posY = Utilities.parseInt(params.getString(POS_Y));
			
			long roomID = sender.getLastJoinedRoom();
			Room r = this.getParentExtension().getParentZone().getRoomById(roomID);
			
			RoomGameControler controler = TTTExtension.getGameControler(r);
			controler.playGame(sender, posX, posY);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		
	}

}
