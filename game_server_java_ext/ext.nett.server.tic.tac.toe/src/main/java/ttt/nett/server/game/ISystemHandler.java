package ttt.nett.server.game;

import nett.server.st.game.entity.User;

public interface ISystemHandler {
	void joinRoom(User user);
	void leaveRoom(User user);
	void disconnect(User user, String playBoardId);
}
