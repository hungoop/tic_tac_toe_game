package ttt.nett.server.game;

import org.json.JSONArray;
import org.json.JSONObject;

import nett.server.st.game.entity.User;

public interface IGameApi {
	
	void sendUserList(User sender, JSONArray jArr);
	void sendGameData(User sender, JSONObject jArr);

}
