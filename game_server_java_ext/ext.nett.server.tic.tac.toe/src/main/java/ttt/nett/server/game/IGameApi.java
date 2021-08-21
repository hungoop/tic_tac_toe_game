package ttt.nett.server.game;


import org.json.JSONArray;
import org.json.JSONObject;
import nett.server.st.game.entity.User;

public interface IGameApi {
	
	void sendUsersFree(User sender, JSONArray jArr);
	void sendUserListOfRoom(User sender, JSONArray jArr);
	void sendGameData(User sender, JSONObject jArr);
	void sendGameData(JSONObject gameData);
	
	void sendInviteData(User sender, JSONArray jArr);

}
