package ttt.nett.server.model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import org.json.JSONArray;

import nett.server.st.game.entity.User;
import ttt.nett.server.command.TEAM_TYPE;
import ttt.nett.server.model.entity.TTTPlayer;

public class TTTPlayerManger {
	private Map<String, TTTPlayer> _players;
	
	public TTTPlayer getPlayer(String userID) {
		return _players.get(userID);
	}
	
	public List<TTTPlayer> getAllPlayers() {
        return new ArrayList<TTTPlayer>(this._players.values());
    }

	public void addPlayer(TTTPlayer user) {
		this._players.put(user.playerID(), user);
	}
	
	public void removePlayer(TTTPlayer user) {
		this._players.remove(user.playerID());
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
	
	public int slotPlayer(User user) {
		for (int i = 0; i < _players.size(); i++) {
			TTTPlayer player = getAllPlayers().get(i);
			if(player.playerID().equals(user.getId()) ) {
				return i;
			}
		}
		return 0;
	}
	
	public void updateTeam() {
		for (int i = 0; i < _players.size(); i++) {
			TTTPlayer player = getAllPlayers().get(i);
			
			player.setTeam(TEAM_TYPE.parse(i));
			
		}
	}

}
