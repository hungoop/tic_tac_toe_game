import 'dart:convert';

class PositionRes{
  int x;
  int y;
  TEAM_TYPE type;

  PositionRes(this.x, this.y, {this.type = TEAM_TYPE.UNKNOWN});

  factory PositionRes.fromJson(dynamic json){
    return PositionRes(
      json["x"],
      json["y"],
      type: TEAM_TYPE_EXT.parse(json["t"]),
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {};
    map['x'] = this.x;
    map['y'] = this.y;
    map['t'] = this.type.getId();
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }



}


enum TEAM_TYPE {
  UNKNOWN,//0
  GREEN,//1
  BLUE,//2
}

extension TEAM_TYPE_EXT on TEAM_TYPE {
  static TEAM_TYPE parse(int typeId){
    return TEAM_TYPE.values.firstWhere((element) {
      return element.getId() == typeId;
    }, orElse: () => TEAM_TYPE.UNKNOWN);
  }

  _eTypeId(TEAM_TYPE key){
    switch (key) {
      case TEAM_TYPE.UNKNOWN: {
        return 0;
      }
      case TEAM_TYPE.GREEN: {
        return 1;
      }
      case TEAM_TYPE.BLUE: {
        return 2;
      }
      default:{
        return 0;
      }
    }
  }

  _eTypeName(TEAM_TYPE key){
    switch (key) {
      case TEAM_TYPE.UNKNOWN: {
        return "UNKNOWN";
      }
      case TEAM_TYPE.GREEN: {
        return "GREEN";
      }
      case TEAM_TYPE.BLUE: {
        return "BLUE";
      }
      default:{
        return "UNKNOWN";
      }
    }
  }

  int getId(){
    return _eTypeId(this);
  }

  String getName(){
    return _eTypeName(this);
  }
}