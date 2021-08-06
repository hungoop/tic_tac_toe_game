import 'package:game_client_flutter/exception/base_chat_exception.dart';

class WebsocketException extends BaseChatException {
  WebsocketException(String errorMessage) : super(errorMessage);
}