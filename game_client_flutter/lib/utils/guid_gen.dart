import 'package:uuid/uuid.dart';

class GUIDGen {
  static String generate() {
    return Uuid().v1();
  }
}