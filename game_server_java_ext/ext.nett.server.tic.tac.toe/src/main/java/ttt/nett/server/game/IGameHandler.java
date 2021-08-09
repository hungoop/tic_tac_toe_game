package ttt.nett.server.game;

import org.json.JSONArray;
import org.json.JSONObject;

import nett.server.st.game.entity.User;
import ttt.nett.server.model.entity.Position;
import ttt.nett.server.model.entity.TTTPlayer;

public interface IGameHandler extends ISystemHandler {
	
	JSONObject getData();
	
	TTTPlayer start(User user);
	
	TTTPlayer stop(User user);
	
	Position play(User user, int x, int y);
	
	JSONArray getUserList();

}
