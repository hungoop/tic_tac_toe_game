import 'package:game_client_flutter/models/models.dart';
import 'package:game_client_flutter/repository/repository.dart';

class RoomListModel {
  List<RoomView> dataViews;

  RoomListModel(this.dataViews);

  factory RoomListModel.fromRes(List<RoomRes> lst){
    List<RoomView> temps = lst.map((e) {
      return RoomView(e);
    }).toList();

    return RoomListModel(temps);
  }

  static List<RoomRes> parseRes(DataPackage data){
    List<RoomRes> lst = data.dataToList().map((e) {
      return RoomRes.fromJson(e);
    }).toList();

    return lst;
  }

}