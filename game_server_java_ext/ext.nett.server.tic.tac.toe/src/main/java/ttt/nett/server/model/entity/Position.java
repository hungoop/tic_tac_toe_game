package ttt.nett.server.model.entity;

import org.json.JSONObject;

public class Position {
	private int _x;
	private int _y;
	
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
	}
	
	public JSONObject toJson() {
		JSONObject jO = new JSONObject();
		jO.put("x", getX());
		jO.put("y", getY());
		return jO;
	}

}
