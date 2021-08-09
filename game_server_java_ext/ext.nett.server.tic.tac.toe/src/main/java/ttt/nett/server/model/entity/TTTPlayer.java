package ttt.nett.server.model.entity;

import org.json.JSONObject;

import nett.server.st.game.entity.User;

public class TTTPlayer {
	private User _user;
	private boolean _myTurn;
	private String _nickName;
	
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
