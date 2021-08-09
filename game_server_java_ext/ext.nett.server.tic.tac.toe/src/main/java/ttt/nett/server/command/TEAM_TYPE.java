package ttt.nett.server.command;

public enum TEAM_TYPE {
	NONE(0),
	GREEN(1),
	BLUE(2);
	
	int _id;
	
	public int id() {
		return _id;
	}
	
	TEAM_TYPE(int id) {
		_id = id;
	}
	
	
	public static TEAM_TYPE parse(int value) {
		for(TEAM_TYPE t : TEAM_TYPE.values()) {
			if(t.id() == value) {
				return t;
			}
		}
		
		return TEAM_TYPE.NONE;
		
	}
	
	
}
