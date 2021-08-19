package ttt.nett.server.command;

public enum BOARD_STATUS {
	WAITING(0),
	STARTING(1),
	PLAYING(2),
	STOPING(3);
	
	int _id;
	
	public int id() {
		return _id;
	}
	
	BOARD_STATUS(int id) {
		_id = id;
	}
	
}
