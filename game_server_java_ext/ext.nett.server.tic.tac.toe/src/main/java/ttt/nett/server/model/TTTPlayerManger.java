package ttt.nett.server.model;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import org.json.JSONArray;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTPlayerManger {
	private Map<String, TTTPlayer> _players;
	
	public TTTPlayer getPlayer(String userID) {
		return _players.get(userID);
	}

	public void setPlayer(TTTPlayer user) {
		this._players.put(user.playerID(), user);
	}

	public TTTPlayerManger() {
		_players = new LinkedHashMap<String, TTTPlayer>();
	}
	
	public JSONArray toJson() {
		JSONArray jA = new JSONArray();
		
		for (Entry<String, TTTPlayer> user : _players.entrySet()) {
			jA.put(user.getValue().toJson());
		}
		
		return jA;
	}
	
	public int count() {
		return _players.size();
	}

}
