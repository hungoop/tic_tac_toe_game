package ttt.nett.server.game.impl;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import nett.server.st.game.entity.User;
import ttt.nett.server.game.IGameApi;
import ttt.nett.server.game.IGameHandler;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.model.entity.Position;

public class RoomGameControler {
	private static Logger log = LogExt.getLogApp(RoomGameControler.class);
	private IGameHandler _gameHandler;
	private IGameApi _gameApi;
	
	public RoomGameControler(IGameApi gameApi, TTTGameHandler gameHandler) {
		_gameApi = gameApi;
		_gameHandler = gameHandler;
	}
	
	public void joinGame(User user) {
		// xu ly join game
		_gameHandler.joinRoom(user);
		
		// send data to client
		JSONObject gameData = _gameHandler.getData();
		log.debug("gameData=>" + gameData.toString());
		_gameApi.sendGameData(user, gameData);
	}
	
	public void leaveGame(User user) {
		_gameHandler.leaveRoom(user);
		
		// send data to client
		//JSONObject gameData = _gameHandler.getData();
		//log.debug("gameData=>" + gameData.toString());
		//_gameApi.sendGameData(user, gameData);
	}
	
	public void disconnectGame(User user) {
		_gameHandler.disconnect(user);
		
		// send data to client
		//JSONObject gameData = _gameHandler.getData();
		//log.debug("gameData=>" + gameData.toString());
		//_gameApi.sendGameData(user, gameData);
	}
	
	public void startGame(User user) {
		// TODO xu ly start game
		_gameHandler.start(user);
	}
	
	public void stopGame(User user) {
		// TODO xu ly stop game
		// xu ly win lose
		_gameHandler.stop(user);
	}
	
	public void playGame(User user, int x, int y) {
		Position pos = _gameHandler.play(user, x, y);
		
		if(pos != null) {
			// send data to client
			JSONObject gameData = _gameHandler.getData();
			log.debug("gameData=>" + gameData.toString());
			_gameApi.sendGameData(gameData);
		}
		
	}
	
	public void getUserListOfRoom(User sender) {
		_gameApi.sendUserListOfRoom(sender, _gameHandler.getUserListOfRoom());
	}
	
	public void getUserListFree(User sender) {
		_gameApi.sendUsersFree(sender, _gameHandler.getUserListFree());
	}
	
	public void sendInviteData(User sender, JSONArray jArr) {
		_gameApi.sendInviteData(sender, jArr);
	}
	

}
