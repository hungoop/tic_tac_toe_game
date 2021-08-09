package ttt.nett.server;

import org.slf4j.Logger;

import nett.server.st.game.entity.Room;
import nett.server.st.game.event.GEventType;
import nett.server.st.game.extension.GExtensionHTTP;
import ttt.nett.server.command.CMD;
import ttt.nett.server.config.CfgExtenstion;
import ttt.nett.server.game.impl.GameAPI;
import ttt.nett.server.game.impl.RoomGameControler;
import ttt.nett.server.game.impl.TTTGameHandler;
import ttt.nett.server.handler.system.*;
import ttt.nett.server.log.LogExt;

public class TTTExtension extends GExtensionHTTP {
	private static Logger log = LogExt.getLogApp(TTTExtension.class);

	@Override
	public void init() {
		LogExt.appId = this.getZoneName();
		log = LogExt.getLogApp(TTTExtension.class);
		CfgExtenstion.getInstance().loadConfigFile(this.getZoneName());
		
		
		this.addEventHandler(GEventType.SERVER_READY, ServerReadyHandler.class);
		this.addEventHandler(GEventType.ZONE_ADDED, ZoneAddedHandler.class);
		this.addEventHandler(GEventType.USER_JOIN_ZONE, UserJoinZoneHandler.class);
		this.addEventHandler(GEventType.USER_LOGIN, UserLoginHandler.class);
		
		this.addEventHandler(GEventType.USER_JOIN_ROOM, UserJoinRoomHandler.class);
		
		this.addEventHandler(GEventType.USER_LEAVE_ROOM, UserLeaveRoomHandler.class);
		this.addEventHandler(GEventType.USER_DISCONNECT, UserDisconnectHandler.class);
		this.addEventHandler(GEventType.USER_LOGOUT, UserLogoutHandler.class);
		
		this.addEventHandler(GEventType.ROOM_ADDED, RoomAddedHandler.class);
		this.addEventHandler(GEventType.ROOM_REMOVED, RoomRemovedHandler.class);
		
		
		for (CMD ad_cmd : CMD.values()) {
			if(ad_cmd.getClzzHttp() != null){
				this.addHTTPRequestHandler(ad_cmd.getCmd(), ad_cmd.getClzzHttp());
			}
			if(ad_cmd.getClzzWSocket() != null){
				this.addRequestHandler(ad_cmd.getCmd(), ad_cmd.getClzzWSocket());
			}
		}
		
		log.debug("INIT TIC TAC TOE ZONE");
	}

	@Override
	public void destroy() {
		this.removeEventHandler(GEventType.SERVER_READY);
		this.removeEventHandler(GEventType.ZONE_ADDED);
		this.removeEventHandler(GEventType.USER_JOIN_ZONE);
		this.removeEventHandler(GEventType.USER_LOGIN);
		this.removeEventHandler(GEventType.USER_JOIN_ROOM);
		this.removeEventHandler(GEventType.USER_LEAVE_ROOM);
		this.removeEventHandler(GEventType.USER_DISCONNECT);
		this.removeEventHandler(GEventType.USER_LOGOUT);
		this.removeEventHandler(GEventType.ROOM_ADDED);
		this.removeEventHandler(GEventType.ROOM_REMOVED);
		

		for (CMD ad_cmd : CMD.values()) {
			if(!ad_cmd.getCmd().equals("*")) {
				this.removeHTTPRequestHandler(ad_cmd.getCmd());
				this.removeRequestHandler(ad_cmd.getCmd());
			}
		}
		
		log.debug("DESTROY TIC TAC TOE ZONE");

	}
	
	
	public static RoomGameControler getGameControler(Room roomGame) {
		return (RoomGameControler) roomGame.getProperty(RoomGameControler.class);
	}
	
	public void setGameControler(Room roomGame) {
		roomGame.setProperty(
				RoomGameControler.class, 
				new RoomGameControler(
						new GameAPI(this, roomGame),
						new TTTGameHandler(roomGame)
				)
		);
	}

}
