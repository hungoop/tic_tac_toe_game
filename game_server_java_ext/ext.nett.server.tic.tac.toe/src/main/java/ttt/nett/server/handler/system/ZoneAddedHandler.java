package ttt.nett.server.handler.system;

import org.slf4j.Logger;

import nett.server.st.game.Instantiation;
import nett.server.st.game.entity.Zone;
import nett.server.st.game.event.GEvent;
import nett.server.st.game.event.GEventParam;
import nett.server.st.game.exception.GException;
import nett.server.st.game.extension.BaseServerEventHandler;
import ttt.nett.server.log.LogExt;

@Instantiation(Instantiation.InstantiationMode.SINGLE_INSTANCE)
public class ZoneAddedHandler extends BaseServerEventHandler {
	private static Logger log = LogExt.getLogApp(ZoneAddedHandler.class);

	@Override
	public void handleServerEvent(GEvent event) throws GException {
		Zone zone = (Zone) event.getParameter(GEventParam.ZONE);
		
		log.debug("zone: " + zone.getName());

	}

}
