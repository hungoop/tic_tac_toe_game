package ttt.nett.server.game.logic;

import nett.server.st.game.entity.User;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTLogic {
	private TTTBoard _board;
	
	public TTTLogic(TTTBoard board){
		_board = board;
	}
	
	public TTTPlayer joinRoom(User user) {
		return _board.userJoin(user);
	}

}
