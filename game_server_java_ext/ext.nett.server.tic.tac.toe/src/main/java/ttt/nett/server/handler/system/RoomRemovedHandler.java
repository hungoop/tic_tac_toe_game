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
import ttt.nett.server.command.CMD;
import ttt.nett.server.log.LogExt;
import ttt.nett.server.util.MessUtils;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class RoomRemovedHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(RoomRemovedHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		Room room = (Room) event.getParameter(GEventParam.ROOM);
		
		log.debug(zone.getName() + " RoomRemovedHandler => room:" + room.getName());
		
		JSONArray dataRooms = getRoomList(zone);
		this.getApi().sendToListUser(
				zone.getAllSessions(), 
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
