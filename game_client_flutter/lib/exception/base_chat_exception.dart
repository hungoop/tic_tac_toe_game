
class BaseChatException implements Exception {
  final String message;

  BaseChatException(this.message);

  String toString() {
    return message;
  }
}