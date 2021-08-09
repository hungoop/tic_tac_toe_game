package ttt.nett.server.game.impl;

import org.json.JSONObject;
import org.slf4j.Logger;

import nett.server.st.game.entity.User;
import ttt.nett.server.game.IGameApi;
import ttt.nett.server.game.IGameHandler;
import ttt.nett.server.log.LogExt;

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
	
	public void startGame(User user) {
		// TODO xu ly start game
		
	}
	
	public void stopGame(User user) {
		// TODO xu ly stop game
		// xu ly win lose
		
	}
	
	public void playGame(User user) {
		// TODO xu ly play game
		
	}
	
	public void userGiveUp(User user) {
		// TODO xu ly user bỏ cuộc
		
	}
	
	public void getUserList(User sender) {
		_gameApi.sendUserList(sender, _gameHandler.getUserList());
	}

}
