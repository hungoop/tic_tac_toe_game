
import 'package:flutter/cupertino.dart';

abstract class WsMessageBase {
  final dynamic data;
  @mustCallSuper
  const WsMessageBase({this.data});

}