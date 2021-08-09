package ttt.nett.server.game.logic;

import java.util.Date;
import org.json.JSONArray;
import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.model.TTTRoadMap;
import ttt.nett.server.command.BOARD_STATUS;
import ttt.nett.server.command.TEAM_TYPE;
import ttt.nett.server.model.TTTPlayerManger;
import ttt.nett.server.model.entity.Position;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTBoard {
	private Date _dateTimeStart;
	private TTTPlayerManger _players;
	private TTTRoadMap _roadMap;
	
	private BOARD_STATUS _status = BOARD_STATUS.WAITING;
	
	public BOARD_STATUS getStatus() {
		return _status;
	}

	public void setStatus(BOARD_STATUS _status) {
		this._status = _status;
	}

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
		this._players.addPlayer(user);
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
		jO.put("status", getStatus().id());
		return jO;
	}
	
	public TTTPlayer userJoin(User user) {
		if(_players.count() < 2) {
			TTTPlayer player = new TTTPlayer(user);
			_players.addPlayer(player);
			
			return player;
		}
		
		return null;
	}
	
	public TTTPlayer userLeave(User user) {
		TTTPlayer player = _players.getPlayer(user.getId());
		
		if(player != null) {
			_players.removePlayer(player);
		}
		
		return player;
	}
	
	public TTTPlayer userDisconnect(User user) {
		TTTPlayer player = _players.getPlayer(user.getId());
		
		if(player != null) {
			_players.removePlayer(player);
			//TODO : quản lý thông tin của user chờ reconnect
		}
		
		return player;
	}

	public Position updateRoadMapPos(int x, int y, TEAM_TYPE team) {
		return _roadMap.updateType(x, y, team);
	}
	
	public TTTPlayer userStart(User user) {
		TTTPlayer player = getPlayer(user.getId());
		player.setTeam(TEAM_TYPE.parse(_players.slotPlayer(user)));
		
		return player;
	}
	
	public TTTPlayer userStop(User user) {
		TTTPlayer player = getPlayer(user.getId());
		player.setTeam(TEAM_TYPE.parse(_players.slotPlayer(user)));
		
		return player;
	}
	
}
