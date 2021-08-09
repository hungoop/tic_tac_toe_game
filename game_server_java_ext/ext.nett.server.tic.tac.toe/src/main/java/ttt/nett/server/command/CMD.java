package ttt.nett.server.command;

import admin.nett.server.st.request.http.ext.ErrorHttpRequest;
import nett.server.st.game.extension.BaseClientRequestHandler;
import nett.server.st.game.extension.BaseHTTPClientRequestHandler;
import ttt.nett.server.handler.ext.ws.*;

public enum CMD {
	GAME_DATA("gamedata", null, null),
	USER_IN_ROOM("userinroom", null, GetUserInRoomReqest.class),
	USER_LIST("userlist", null, null),
	ROOM_LIST("roomlist", null, null),
	STOP_GAME("stopgame", null, StopGameWSRequest.class),
	START_GAME("startgame", null, StartGameWSRequest.class),
	PLAY_GAME("playgame", null, PlayGameWSRequest.class),
	INVITE_FRIEND("invitefriend", null, InviteFriendWSRequest.class),
	GET_TIME("gettime", null, GetTimeServerWSRequest.class),
	REQUEST_WRONG("*", ErrorHttpRequest.class, null);
	
	private String _cmd;
	private Class<? extends BaseHTTPClientRequestHandler> _clzzHttp;
	private Class<? extends BaseClientRequestHandler> _clzzWSocket;
	
	private CMD(String cmd, Class<? extends BaseHTTPClientRequestHandler> clzzHttp, Class<? extends BaseClientRequestHandler> clzzWSocket) {
		_cmd = cmd;
		_clzzHttp = clzzHttp;
		_clzzWSocket = clzzWSocket;
	}
	
	public String getCmd(){
		return _cmd;
	}
	
	public Class<? extends BaseHTTPClientRequestHandler> getClzzHttp() {
		return (Class<? extends BaseHTTPClientRequestHandler>) _clzzHttp;
	}
	
	public Class<? extends BaseClientRequestHandler> getClzzWSocket() {
		return (Class<? extends BaseClientRequestHandler>) _clzzWSocket;
	}

}
