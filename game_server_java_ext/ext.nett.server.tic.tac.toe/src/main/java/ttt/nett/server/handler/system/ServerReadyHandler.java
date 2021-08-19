package ttt.nett.server.handler.system;

import org.slf4j.Logger;
import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.CreateRoomSettings;
import nett.server.st.game.entity.CreateRoomSettings.RoomRemoveMode;
import nett.server.st.game.entity.Room;
import nett.server.st.game.entity.Zone;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GCreateRoomException;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.TTTExtension;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class ServerReadyHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(ServerReadyHandler.class);
	TTTExtension ext;

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zon = (Zone) event.getParameter(GEventParam.ZONE);
		log.debug(" >>>>>>>>>>>>>>>>||||||||||||||ReadyHandler |||||||||||||||<<<<<<<<<<<<<<<< " + zon.getName());
		
		ext = (TTTExtension) getParentExtension();
		
		
		initRoomTest();

	}
	
	private void initRoomTest() {
		for (int i = 0; i < 2; i++) {
			makeRoom("ttt_room_" + i);
			//Room r = makeRoom("ttt_room_" + i);
			//ext.setGameControler(r);
		}
		
	}
	
	private Room makeRoom(String roomName){
		Room room = null;
		CreateRoomSettings rst = new CreateRoomSettings();
		rst.setName(roomName);
		rst.setNotifyEnterRoom(true);
		rst.setNotifyExitRoom(true);
		rst.setNotifyUserLost(true);
		rst.setMaxPlayers(10);
		rst.setMaxSpectators(100);
		rst.setAutoRemoveMode(RoomRemoveMode.NEVER_REMOVE);
		
		try {
			room = getApi().createRoom(ext.getParentZone(), rst, null, false, null, true, true);
			log.info("TTT create room name: " + roomName + " OK");
			
		} catch (GCreateRoomException e) {
			log.error("TTT create room name: " + roomName + " ERROR: " + e.getMessage());
		}
		
		return room;
	}
	

}
