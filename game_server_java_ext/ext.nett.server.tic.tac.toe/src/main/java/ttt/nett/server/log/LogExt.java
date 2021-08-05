package ttt.nett.server.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogExt {
	public static final String FIRESTORE_DB_LOG 		= "firestore.";
	public static String appId 							= null;
	
	public static Logger getLogApp(Class<?> clazz) {
		Logger log;
		if(appId == null){
			log = LoggerFactory.getLogger(clazz);
		} else {
			log = LoggerFactory.getLogger(appId + clazz.getName());
		}
		
		return log;
	}
	
	public static Logger getLogFirestore(Class<?> clazz) {
		Logger log = LoggerFactory.getLogger(FIRESTORE_DB_LOG + clazz.getName());
		return log;
	}

}
