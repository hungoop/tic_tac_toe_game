package ttt.nett.server.model.entity;

import org.json.JSONObject;

import ttt.nett.server.command.TEAM_TYPE;

public class Position {
	private int _x;
	private int _y;
	
	private TEAM_TYPE _type; 
	
	public TEAM_TYPE getType() {
		return _type;
	}

	public void setType(TEAM_TYPE type) {
		this._type = type;
	}

	public int getX() {
		return _x;
	}

	public void setX(int x) {
		this._x = x;
	}

	public int getY() {
		return _y;
	}

	public void setY(int y) {
		this._y = y;
	}
	
	public Position(int x, int y) {
		this._x = x;
		this._y = y;
		this._type = TEAM_TYPE.NONE;
	}
	
	public JSONObject toJson() {
		JSONObject jO = new JSONObject();
		jO.put("x", getX());
		jO.put("y", getY());
		jO.put("t", getType().id());
		return jO;
	}

}
