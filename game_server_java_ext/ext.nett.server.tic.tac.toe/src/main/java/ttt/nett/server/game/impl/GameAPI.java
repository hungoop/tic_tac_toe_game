package ttt.nett.server.game.impl;

import java.util.LinkedList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import admin.nett.server.st.AdConfig;
import nett.server.st.data.Session;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.User;
import nett.server.st.game.exception.GNullException;
import nett.server.st.game.extension.GExtension;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.command.CMD;
import ttt.nett.server.game.IGameApi;
import ttt.nett.server.util.MessUtils;

public class GameAPI implements IGameApi {
	private GExtension _ext;
	private Room _roomGame;

	public GameAPI(TTTExtension ext, Room room) {
		super();
		this._ext = ext;
		this._roomGame = room;
	}

	@Override
	public void sendUserListOfRoom(User sender, JSONArray jArr) {
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
	
	@Override
	public void sendGameData(JSONObject gameData) {
		_ext.send(
				CMD.GAME_DATA.getCmd(),
				MessUtils.makeJsonData(gameData), 
				_roomGame.getSessionList()
		);
	}

	@Override
	public void sendInviteData(User sender, JSONArray jArr) {
		List<Session> ssLst = getSessionsByIDs(jArr);
		
		_ext.send(
				CMD.INVITE_FRIEND.getCmd(),
				MessUtils.makeJsonData(_roomGame.toJson(AdConfig.LEVEL_ROOM)), 
				ssLst
		);
	}
	
	private List<Session> getSessionsByIDs(JSONArray jArr){
		List<Session> rsLst = new LinkedList<Session>();
		
		for(int i = 0; i < jArr.length(); i++) {
			try {
				String uID = (String) jArr.get(i);
				User u = _ext.getApi().getUserById(uID);
				rsLst.add(u.getSession());
			} catch (GNullException e) {
				e.printStackTrace();
			}
		}
		
		return rsLst;
	}

	@Override
	public void sendUsersFree(User sender, JSONArray jArr) {
		_ext.send(
				CMD.USER_LIST_FREE.getCmd(),
				MessUtils.makeJsonData(jArr), 
				sender
		);
	}

}
