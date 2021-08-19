package ttt.nett.server.game.logic;

import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.command.TEAM_TYPE;
import ttt.nett.server.model.entity.Position;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTLogic {
	private TTTBoard _board;
	
	// quản lý thông tin play game
	// + ván game đang diễn ra
	// + ván game đang chờ
	
	// quản lý thông tin user
	// + join đồng ý làm người chơi 
	// + or chỉ xem
	// + chuyển từ người chơi thành  người xem
	
	// quản lý trạng thái room
	// + khi nào start, stop, result game
	// + user join, leave, disconnect(network error), logout, 
	// + xác định chủ bàn
	// + 
	
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
