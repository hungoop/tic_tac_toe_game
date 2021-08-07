package ttt.nett.server.util;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;

//import com.google.cloud.Timestamp;

import nett.server.st.game.exception.GParseException;
import nett.server.st.util.Utilities;
import ttt.nett.server.log.LogExt;


public class MessUtils {
	private static Logger log = LogExt.getLogApp(MessUtils.class);
	
	private static String TAG = MessUtils.class.getName();
    public static final int isOK = 0;
    public static final int isERROR = 1;
    
    public static final String STATUS_CODE = "code";
    public static final String DATA_KEY = "data";
    public static final String MSG_KEY = "msg";
    
    public static final String KEY_TOKEN = "token";

    public static boolean hasError(JSONObject jO){
        boolean isErr = true;

        try {
            int code = jO.getInt(STATUS_CODE);
            if(code == isOK){
                isErr = false;
            }
        } catch (JSONException e) {
        	log.error(TAG, e);
        }

        return isErr;
    }

    public static String getErrorMessage(JSONObject jO){
        String message = "";

        try {
            message = jO.getString(MSG_KEY);
        } catch (JSONException e) {
        	log.error(TAG, e);
        }

        return message;
    }

    public static JSONArray getJSONArrayData(JSONObject jO){
        JSONArray jArr = new JSONArray();

        try {
            jArr = Utilities.parseJSONArray(jO.getString(DATA_KEY));
        } catch (JSONException | GParseException e) {
        	log.error(TAG, e);
        }

        return jArr;
    }

    public static JSONObject getJSONObjectData(JSONObject jO){
        JSONObject jObj = new JSONObject();

        try {
            jObj = Utilities.parseJSON(jO.getString(DATA_KEY));
        } catch (JSONException | GParseException e) {
        	log.error(TAG, e);
        }

        return jObj;

    }

    public static String getStringData(JSONObject jO){
        String rs = "";

        try {
            rs = jO.getString(DATA_KEY);
        } catch (JSONException e) {
        	log.error(TAG, e);
        }

        return rs;

    }

    public static int getIntData(JSONObject jO) throws JSONException {
        int rs = 0;
        rs = jO.getInt(DATA_KEY);
        return rs;

    }

    public static boolean getBooleanData(JSONObject jO){
        boolean rs = true;

        try {
            rs = jO.getBoolean(DATA_KEY);
        } catch (JSONException e) {
        	log.error(TAG, e);
        }

        return rs;

    }
    public static JSONObject makeJsonError(String messError) {
        JSONObject jo = new JSONObject();
        try {
            jo.put(STATUS_CODE, isERROR);
            jo.put(MSG_KEY, messError == null ? "" : messError);
            jo.put(DATA_KEY, "");
        } catch (JSONException e) {
        	log.error(TAG, e);
        }
        return jo;
    }
    public static JSONObject makeJsonError(String messError, String data) {
        JSONObject jo = new JSONObject();
        try {
            jo.put(STATUS_CODE, isERROR);
            jo.put(MSG_KEY, messError == null ? "" : messError);
            jo.put(DATA_KEY, data);
        } catch (JSONException e) {
        	log.error(TAG, e);
        }
        return jo;
    }

    public static JSONObject makeJsonData(String data) {
        JSONObject jo = new JSONObject();
        try {
            jo.put(STATUS_CODE, isOK);
            jo.put(MSG_KEY, "");
            jo.put(DATA_KEY, data);
        } catch (JSONException e) {
        	log.error(TAG, e);
        }
        return jo;
    }
    public static JSONObject makeJsonData(JSONObject data) {
        return makeJsonData(data.toString());
    }
    public static JSONObject makeJsonData(JSONArray data) {
    	return makeJsonData(data.toString());
    }
    
    /*
    @SuppressWarnings("unchecked")
	public static JSONObject mapToJson(Map<String, Object> map) {
		JSONObject jrs = new JSONObject();
		
		Set<String> keys = map.keySet();
		for (String key : keys) {
			if(map.get(key) instanceof Timestamp) {

				jrs.accumulate(key, map.get(key).toString());
				//log.debug(map.get(key).getClass() + " : " + map.get(key));
			} else if(map.get(key) instanceof Map<?, ?>) {
				jrs.accumulate(key, mapToJson((Map<String, Object>) map.get(key)));
			} else {
				jrs.accumulate(key, map.get(key));
			}
		}
		
		return jrs;
	}*/
    
    
}
