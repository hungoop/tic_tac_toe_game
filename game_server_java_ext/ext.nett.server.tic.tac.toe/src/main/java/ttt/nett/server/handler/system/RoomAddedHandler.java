package ttt.nett.server.handler.system;

import java.util.List;

import org.json.JSONArray;
import org.slf4j.Logger;

import admin.nett.server.st.AdConfig;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.*;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.command.CMD;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.util.MessUtils;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class RoomAddedHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(RoomAddedHandler.class);
	TTTExtension ext;

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		Room room = (Room) event.getParameter(GEventParam.ROOM);
		String tempData = (String) event.getParameter(GEventParam.ROOM_TEMP_DATA);

		log.debug(zone.getName() + " RoomAddedHandler => " + room.getName() + ", tempData: " + tempData.toString());

		ext = (TTTExtension) getParentExtension();
		
		ext.setGameControler(room);
		
		JSONArray dataRooms = getRoomList(zone);
		this.getApi().sendToListUser(
				ext.getSessionLst(), 
				CMD.ROOM_LIST.getCmd(), 
				MessUtils.makeJsonData(dataRooms)
			);
		
	}
	
	private JSONArray getRoomList(Zone zone) {
		List<Room> roomLst = zone.getRoomList();
		
		JSONArray jArr = new JSONArray();
		for(Room r : roomLst) {
			jArr.put(r.toJson(AdConfig.LEVEL_ROOM));
		}
		
		return jArr;
		
	}

}
