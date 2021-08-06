class Preferences {
  static String cleanUp                   = 'cleanUp';
  static String localTimeZone             = 'localTimeZone';
  static String language                  = 'language';
  static String languageCode              = 'languageCode';
  static String countryCode               = 'countryCode';
  static String theme                     = 'theme';
  static String darkOption                = 'darkOption';
  static String font                      = 'font';
  static const String KEY_TOKEN 			    = "token";
  static const String KEY_LIST_TOKEN 			= "listToken";
  static const String KEY_LOGIN_RES 			= "loginRes";
  static const String RUN_SERVICE_NOTIFY 	= "isRunService";

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
