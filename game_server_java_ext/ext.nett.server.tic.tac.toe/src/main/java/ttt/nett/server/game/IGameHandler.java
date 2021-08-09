package ttt.nett.server.game;

import org.json.JSONArray;
import org.json.JSONObject;

public interface IGameHandler extends ISystemHandler {
	
	JSONObject getData();
	
	void start();
	
	void stop();
	
	void play();
	
	JSONArray getUserList();

}
