package ttt.nett.server.model.entity;

import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.command.TEAM_TYPE;

public class TTTPlayer {
	private User _user;
	private boolean _myTurn;
	private String _nickName;
	
	private TEAM_TYPE _team;
	
	
	
	public TEAM_TYPE getTeam() {
		return _team;
	}

	public void setTeam(TEAM_TYPE team) {
		this._team = team;
	}

	public boolean isMyTurn() {
		return _myTurn;
	}

	public void setMyTurn(boolean _myTurn) {
		this._myTurn = _myTurn;
	}

	public String getNickName() {
		return _nickName;
	}

	public void setNickName(String _nickName) {
		this._nickName = _nickName;
	}
	
	public User getUser() {
		return _user;
	}

	public TTTPlayer(User user){
		_user = user;
		_myTurn = false;
		_team = TEAM_TYPE.NONE;
	}
	
	public String playerID() {
		return getUser().getId();
	}
	
	public JSONObject toJson() {
		JSONObject jO = new JSONObject();
		jO.put("turn", isMyTurn());
		jO.put("nick", getNickName());
		jO.put("user", getUser().toJson());
		return jO;
	}

}
