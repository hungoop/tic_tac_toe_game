package ttt.nett.server.game.logic;

import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.command.TEAM_TYPE;
import ttt.nett.server.model.entity.Position;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTLogic {
	private TTTBoard _board;
	
	public JSONObject getData() {
		return _board.toJson();
	}		
	
	public TTTLogic(TTTBoard board){
		_board = board;
	}
	
	public TTTPlayer joinRoom(User user) {
		return _board.userJoin(user);
	}
	
	public TTTPlayer leaveRoom(User user) {
		return _board.userLeave(user);
	}
	
	public TTTPlayer disconnect(User user) {
		return _board.userDisconnect(user);
	}
	
	public Position play(int x, int y, TEAM_TYPE team) {
		return _board.updateRoadMapPos(x, y, team);
	}
	
	public TTTPlayer start(User user) {
		return _board.userStart(user);
	}
	
	public TTTPlayer stop(User user) {
		return _board.userStop(user);
	}

}
