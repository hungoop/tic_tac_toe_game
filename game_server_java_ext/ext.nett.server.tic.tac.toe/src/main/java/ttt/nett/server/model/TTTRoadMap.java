package ttt.nett.server.model;

import org.json.JSONArray;

import ttt.nett.server.command.TEAM_TYPE;
import ttt.nett.server.model.entity.Position;

public class TTTRoadMap {
	public static final int NUM_PER_LINE = 5;
	
	private Position[][] _roadMap;
	
	public TTTRoadMap() {
		_roadMap = new Position[NUM_PER_LINE][NUM_PER_LINE];
		initRoadMap();
	}
	
	private void initRoadMap() {
		for (int i = 0; i < NUM_PER_LINE; i++) {
			for (int j = 0; j < NUM_PER_LINE; j++) {
				_roadMap[i][j] = new Position(i, j);
			}
		}
	}
	
	public JSONArray toJson() {
		JSONArray jA = new JSONArray();
		for (int i = 0; i < NUM_PER_LINE; i++) {
			for (int j = 0; j < NUM_PER_LINE; j++) {
				Position pos = _roadMap[i][j];
				
				jA.put(pos.toJson());
			}
		}
		
		return jA;
	}
	
	public Position updateType(int x, int y, TEAM_TYPE type) {
		if(x < NUM_PER_LINE && y < NUM_PER_LINE) {
			Position pos = _roadMap[x][y];
			
			if(pos.getType() == TEAM_TYPE.NONE) {
				pos.setType(type);
			}
			
			return pos;
			
		}
		
		return null;
	}

}
