import 'package:hive/hive.dart';
import 'package:sns_auth_demo/provider/auth_provider.dart';

class Storage {
  final box = Hive.box('box');

  void writeUid({required String uid}) {
    box.put('uid', uid);
  }

  String readUid() {
    return box.get('uid');
  }

  void writeAuthType({required AuthType authType}) {
    box.put('authType', authType.toString());
  }

  String readAuthType() {
    return box.get('authType');
  }
}
