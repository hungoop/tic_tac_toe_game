package ttt.nett.server.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import org.slf4j.Logger;
import nett.server.st.ConfigServer;
import nett.server.st.game.exception.GParseException;
import nett.server.st.util.Utilities;
import ttt.nett.server.log.LogExt;

public class CfgExtenstion {
	private static Logger log = LogExt.getLogApp(CfgExtenstion.class);
	
	private static CfgExtenstion _instance;
	private final static String PREFIX_FOLDER_CONFIG 		= "server_";
	private final static String CONFIG_NAME 				= "game.config.properties";
	
	public synchronized static CfgExtenstion getInstance() {
		if(_instance == null) {
			_instance = new CfgExtenstion();
		}
		return _instance;
	}
	
	
	private String rabbitMQExchangeName;
	private String secretJWTKey;
	private String issuser;
	private int acceptExpireAt;
	private boolean addExpireTime;
	
	public String getRabbitMQExchangeName() {
		return rabbitMQExchangeName;
	}

	public String getSecretJWTKey() {
		return secretJWTKey;
	}

	public String getIssuser() {
		return issuser;
	}

	public int getAcceptExpireAt() {
		return acceptExpireAt;
	}

	public boolean isAddExpireTime() {
		return addExpireTime;
	}
	
	public void loadConfigFile(String zoneName) {
		String path = System.getProperty("user.dir") + ConfigServer.EXTENSION_PROP_FOLDER;
		File configFile = new File(path + "/" + PREFIX_FOLDER_CONFIG + zoneName + "/" + CONFIG_NAME);
		
		log.info(">>>>>>>>>>>>>>>>>Load-config-path: " + configFile);
		
		Properties prop = null;
		FileInputStream stream = null;
		
		try {
			prop = new Properties();
			stream= new FileInputStream(configFile);
			prop.load(stream);
			
			rabbitMQExchangeName = prop.getProperty("server.ttt.rabbitmq.lobby.exName");
			secretJWTKey = prop.getProperty("server.ttt.jwt.secret.key");
			issuser = prop.getProperty("server.ttt.jwt.issuser");
			acceptExpireAt = Utilities.parseInt(prop.getProperty("server.ttt.jwt.accept.expires.at"));
			addExpireTime = Utilities.parseBool(prop.getProperty("server.ttt.add.expires.time"));
			
		} catch (FileNotFoundException e) {
			log.error(e.getMessage(), e); 
		} catch (IOException e) {
			log.error(e.getMessage(), e); 
		} catch (GParseException e) {
			log.error(e.getMessage(), e); 
		} finally {
			if(stream != null) {
				try {
					stream.close();
				} catch (IOException e) {
					log.error(e.getMessage(), e); 
				}
			}
			
			if(prop != null) {
				prop.clear();
			}
			
		}
		
	}



}
