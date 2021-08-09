package ttt.nett.server.model;

import java.util.LinkedList;
import java.util.List;
import org.json.JSONArray;

import ttt.nett.server.model.entity.Position;

public class TTTRoadMap {
	private List<Position> _roadMap;
	
	public TTTRoadMap() {
		_roadMap = new LinkedList<Position>();
		initRoadMap();
	}
	
	private void initRoadMap() {
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				_roadMap.add(new Position(i, j));
			}
		}
	}
	
	public JSONArray toJson() {
		JSONArray jA = new JSONArray();
		
		for (Position pos : _roadMap) {
			jA.put(pos.toJson());
		}
		
		return jA;
	}

}
