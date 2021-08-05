package ttt.nett.server;

import org.slf4j.Logger;
import nett.server.st.game.extension.GExtensionHTTP;
import nett.server.st.helper.log.LogExt;

public class TTTExtension extends GExtensionHTTP {
	private static Logger log = LogExt.getLogApp(TTTExtension.class);

	@Override
	public void init() {
		LogExt.appId = "zone_ttt";
		
		log.info("Server Tic Tac Toe INIT");

	}

	@Override
	public void destroy() {
		log.info("Server Tic Tac Toe DESTROY");

	}

}
