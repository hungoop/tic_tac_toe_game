package ttt.nett.server.game.impl;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.User;
import nett.server.st.game.exception.GRoomException;
import ttt.nett.server.game.IGameHandler;
import ttt.nett.server.game.logic.TTTBoard;
import ttt.nett.server.game.logic.TTTLogic;
import ttt.nett.server.game.logic.TTTRule;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.model.entity.Position;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTGameHandler implements IGameHandler {
	private static Logger log = LogExt.getLogApp(TTTGameHandler.class);
	private Room _roomGame;
	private TTTBoard _board;
	private TTTLogic _logic;
	private TTTRule _rule;
	
	
	public TTTGameHandler(Room roomGame) {
		_roomGame = roomGame;
		
		_board = new TTTBoard();
		_rule = new TTTRule();
		_logic = new TTTLogic(_board);
		
	}
	
	@Override
	public void joinRoom(User user) {
		TTTPlayer player = _logic.joinRoom(user);
		if(player != null) {
			try {
				_roomGame.switchSpectatorToPlayer(player.getUser());
			} catch (GRoomException e) {
				log.error(e.getMessage(), e);
			}
		}
	}

	@Override
	public void leaveRoom(User user) {
		TTTPlayer player = _logic.leaveRoom(user);
		if(player != null) {
			try {
				_roomGame.switchPlayerToSpectator(player.getUser());
			} catch (GRoomException e) {
				log.error(e.getMessage(), e);
			}
		}
	}

	@Override
	public void disconnect(User user) {
		TTTPlayer player = _logic.disconnect(user);
	}

	@Override
	public JSONObject getData() {
		return _logic.getData();
	}

	@Override
	public TTTPlayer start(User user) {
		TTTPlayer player = _board.getPlayer(user.getId());
		
		if(player != null) {
			
		}
		
		return player;
	}

	@Override
	public TTTPlayer stop(User user) {
		TTTPlayer player = _board.getPlayer(user.getId());
		
		if(player != null) {
			
		}
		
		return player;
	}

	@Override
	public Position play(User user, int x, int y) {
		TTTPlayer player = _board.getPlayer(user.getId());
		if(player != null) {
			return _logic.play(x, y, player.getTeam());
		}
		
		return null;
	}

	@Override
	public JSONArray getUserList() {
		List<User> userLst = _roomGame.getUserList();
		
		JSONArray jArr = new JSONArray();
		for(User usr : userLst) {
			jArr.put(usr.toJson());
		}
		
		return jArr;
	}
	
	

}
