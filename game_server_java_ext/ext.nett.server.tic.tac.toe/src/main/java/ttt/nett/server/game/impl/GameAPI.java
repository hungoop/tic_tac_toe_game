package ttt.nett.server.game.impl;

import org.json.JSONArray;
import org.json.JSONObject;
import nett.server.st.game.entity.User;
import nett.server.st.game.extension.GExtension;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.command.CMD;
import ttt.nett.server.game.IGameApi;
import ttt.nett.server.util.MessUtils;

public class GameAPI implements IGameApi {
	private GExtension _ext;

	public GameAPI(TTTExtension ext) {
		super();
		this._ext = ext;
	}

	@Override
	public void sendUserList(User sender, JSONArray jArr) {
		_ext.send(
				CMD.USER_IN_ROOM.getCmd(),
				MessUtils.makeJsonData(jArr), 
				sender
		);
		
	}

	@Override
	public void sendGameData(User sender, JSONObject gameData) {
		_ext.send(
				CMD.GAME_DATA.getCmd(),
				MessUtils.makeJsonData(gameData), 
				sender
		);
	}
	
	

}
