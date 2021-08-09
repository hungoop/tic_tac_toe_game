package ttt.nett.server.game.logic;

import java.util.Date;
import org.json.JSONArray;
import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.model.TTTRoadMap;
import ttt.nett.server.model.TTTPlayerManger;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTBoard {
	private Date _dateTimeStart;
	private TTTPlayerManger _players;
	private TTTRoadMap _roadMap;
	
	public Date get_dateTimeStart() {
		return _dateTimeStart;
	}

	public void set_dateTimeStart(Date _dateTimeStart) {
		this._dateTimeStart = _dateTimeStart;
	}

	public TTTPlayer getPlayer(String userID) {
		return _players.getPlayer(userID);
	}

	public void setPlayer(TTTPlayer user) {
		this._players.setPlayer(user);
	}
	
	public TTTRoadMap get_roadMap() {
		return _roadMap;
	}

	public void set_roadMap(TTTRoadMap _roadMap) {
		this._roadMap = _roadMap;
	}

	public TTTBoard(){
		_dateTimeStart = new Date();
		_players = new TTTPlayerManger();
		_roadMap = new TTTRoadMap();
	}
	
	private JSONArray roadMapData() {
		return _roadMap.toJson();
	}
	
	private JSONArray playersData() {
		return _players.toJson();
	}
	
	public JSONObject toJson() {
		JSONObject jO = new JSONObject();
		jO.put("roadMap", roadMapData());
		jO.put("player", playersData());
		
		return jO;
	}
	
	public TTTPlayer userJoin(User user) {
		if(_players.count() < 2) {
			TTTPlayer player = new TTTPlayer(user);
			_players.setPlayer(player);
			return player;
		}
		
		return null;
	}

}
