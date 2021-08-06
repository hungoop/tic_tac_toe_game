
import 'package:game_client_flutter/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class UtilPermission {

  static Future<bool> checkAndRequestMicroAndStorage() async {
    Map<Permission, PermissionStatus> status = await requestMicroAndStorage();
    if(status[Permission.microphone]!.isPermanentlyDenied ||
        status[Permission.storage]!.isPermanentlyDenied){
      return true;
    }
    return false;
  }

  static Future<bool> checkAndRequestPhoto() async {
    Map<Permission, PermissionStatus> status = await requestPhoto();
    if(status[Permission.photos]!.isPermanentlyDenied ||
        status[Permission.storage]!.isPermanentlyDenied ||
        status[Permission.mediaLibrary]!.isPermanentlyDenied
    ){
      return true;
    }
    return false;
  }

  static Future<bool> checkAndRequestCamera() async {
    Map<Permission, PermissionStatus> status = await requestCamera();
    if(status[Permission.camera]!.isPermanentlyDenied ||
        status[Permission.camera]!.isRestricted){
      return true;
    }
    return false;
  }

  static Future<bool> checkAndRequestLocation() async {
    Map<Permission, PermissionStatus> status = await requestLocation();
    if(status[Permission.location]!.isPermanentlyDenied ||
        status[Permission.location]!.isRestricted){
      return true;
    }
    return false;
  }

  static Future<bool> checkAndRequestStorage() async {
    Map<Permission, PermissionStatus> status = await requestStorage();
    if(status[Permission.storage]!.isPermanentlyDenied ||
        status[Permission.mediaLibrary]!.isPermanentlyDenied){
      return true;
    }

    return false;
  }

  static Future<bool> checkAndRequestNotification() async {
    Map<Permission, PermissionStatus> status = await requestNotification();
    if(status[Permission.notification]!.isPermanentlyDenied ||
        status[Permission.notification]!.isRestricted){
      return true;
    }
    return false;
  }

  static Future<Map<Permission, PermissionStatus>> requestLocation() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active location - no handler');

      statuses[Permission.location] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.locationWhenInUse.request().isGranted) {
      print('Permission locationWhenInUse isGranted');
      print('Permission.locationWhenInUse statuses = ${await Permission.locationWhenInUse.request()}');

      statuses[Permission.location] = await Permission.locationWhenInUse.request();
    }
    else if (await Permission.locationAlways.request().isGranted) {
      print('Permission locationAlways isGranted');
      print('Permission.locationAlways statuses = ${await Permission.locationAlways.request()}');

      statuses[Permission.location] = await Permission.locationAlways.request();
    }
    else if (await Permission.location.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission location isGranted');
      print('Permission.location statuses = ${await Permission.location.request()}');

      statuses[Permission.location] = await Permission.location.request();
    }
    else {
      // You can request multiple permissions at once.
      print('requestLocation  Permission.location = ${statuses[Permission.location]}');
      statuses = await [
        Permission.locationWhenInUse,
        Permission.locationAlways,
        Permission.location
      ].request();

      print('Permission.location statuses = ${statuses[Permission.location]}');
      print('Permission.locationAlways statuses = ${statuses[Permission.locationAlways]}');
      print('Permission.locationWhenInUse statuses = ${statuses[Permission.locationWhenInUse]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestCamera() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active camera - no handler');

      statuses[Permission.camera] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission camera isGranted');

      statuses[Permission.camera] = await Permission.camera.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.camera,
      ].request();

      print('Permission.camera statuses = ${statuses[Permission.camera]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestPhoto() async {
    Map<Permission, PermissionStatus> statuses = {};

    if(Utils.isWeb()){
      print('WEB Active PhotoAndMedia - no handler');
      statuses[Permission.photos] = PermissionStatus.granted;
      statuses[Permission.storage] = PermissionStatus.granted;
      statuses[Permission.mediaLibrary] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.photos.request().isGranted &&
        await Permission.storage.request().isGranted &&
        await Permission.mediaLibrary.request().isGranted
    ) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission Photo isGranted');

      statuses[Permission.photos] = await Permission.photos.request();
      statuses[Permission.storage] = await Permission.storage.request();
      statuses[Permission.mediaLibrary] = await Permission.mediaLibrary.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.photos,
        Permission.storage,
        Permission.mediaLibrary,
      ].request();

      print('Permission.photos status  = ${statuses[Permission.photos]}');
      print('Permission.storage status  = ${statuses[Permission.storage]}');
      print('Permission.mediaLibrary status  = ${statuses[Permission.mediaLibrary]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestStorage() async {
    Map<Permission, PermissionStatus> statuses = {};

    if(Utils.isWeb()){
      print('WEB Active Storage - no handler');

      statuses[Permission.storage] = PermissionStatus.granted;
      statuses[Permission.mediaLibrary] = PermissionStatus.granted;
      statuses[Permission.manageExternalStorage] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.storage.request().isGranted &&
        await Permission.mediaLibrary.request().isGranted &&
        await Permission.manageExternalStorage.request().isGranted
    ) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission Storage isGranted');
      print('Permission mediaLibrary isGranted');
      print('Permission manageExternalStorage isGranted');

      statuses[Permission.storage] = await Permission.storage.request();
      statuses[Permission.mediaLibrary] = await Permission.mediaLibrary.request();
      statuses[Permission.manageExternalStorage] = await Permission.manageExternalStorage.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.storage,
        Permission.mediaLibrary,
        Permission.manageExternalStorage,
      ].request();

      print('Permission.storage statuses = ${statuses[Permission.storage]}');
      print('Permission.mediaLibrary statuses = ${statuses[Permission.mediaLibrary]}');
      print('Permission.manageExternalStorage statuses = ${statuses[Permission.manageExternalStorage]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestManageExternalStorage() async {
    Map<Permission, PermissionStatus> statuses = {};

    if(Utils.isWeb()){
      print('WEB Active manageExternalStorage - no handler');

      statuses[Permission.manageExternalStorage] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.manageExternalStorage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission manageExternalStorage isGranted');

      statuses[Permission.manageExternalStorage] = await Permission.manageExternalStorage.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.manageExternalStorage,
      ].request();

      print('Permission.manageExternalStorage statuses = ${statuses[Permission.manageExternalStorage]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestMediaLibrary() async {
    Map<Permission, PermissionStatus> statuses = {};

    if(Utils.isWeb()){
      print('WEB Active Storage - no handler');

      statuses[Permission.mediaLibrary] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.mediaLibrary.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission mediaLibrary isGranted');

      statuses[Permission.mediaLibrary] = await Permission.mediaLibrary.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.mediaLibrary,
      ].request();

      print('Permission.storage statuses = ${statuses[Permission.mediaLibrary]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestMicrophone() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active micro phone - no handler');

      statuses[Permission.microphone] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission microphone isGranted');

      statuses[Permission.microphone] = await Permission.microphone.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.microphone,
      ].request();

      print('Permission.microphone statuses = ${statuses[Permission.microphone]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestCamAndMicro() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active CamAndMicro - no handler');

      statuses[Permission.camera] =  PermissionStatus.granted;
      statuses[Permission.microphone] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.camera.request().isGranted && await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission CamAndMicro isGranted');

      statuses[Permission.camera] = await Permission.camera.request();
      statuses[Permission.microphone] = await Permission.microphone.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.camera,
        Permission.microphone
      ].request();

      print('Permission.camera statuses = ${statuses[Permission.camera]}');
      print('Permission.microphone statuses = ${statuses[Permission.microphone]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestMicroAndStorage() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active MicroAndStorage - no handler');
      statuses[Permission.storage] =  PermissionStatus.granted;
      statuses[Permission.microphone] = PermissionStatus.granted;

      return statuses;
    }

    if (await Permission.storage.request().isGranted && await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission MicroAndStorage isGranted');

      statuses[Permission.storage] = await Permission.storage.request();
      statuses[Permission.microphone] = await Permission.microphone.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.storage,
        Permission.microphone
      ].request();

      print('Permission.storage statuses = ${statuses[Permission.storage]}');
      print('Permission.microphone statuses = ${statuses[Permission.microphone]}');
    }

    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> requestNotification() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Utils.isWeb()) {
      print('WEB Active notification - no handler');

      statuses[Permission.notification] = PermissionStatus.granted;
      return statuses;
    }

    if (await Permission.notification.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print('Permission notification isGranted');

      statuses[Permission.notification] = await Permission.notification.request();
    }
    else {
      // You can request multiple permissions at once.
      statuses = await [
        Permission.notification,
      ].request();

      print('Permission.notification statuses = ${statuses[Permission.notification]}');
    }

    return statuses;
  }

  static void openPermissionAppSettings(){
    openAppSettings();
  }

}