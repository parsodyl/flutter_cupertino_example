import 'package:flutter_cupertino_example/data/sources/user_source.dart';
import 'package:flutter_cupertino_example/entities/user.dart';
import 'package:json_string/json_string.dart';

class UserService {
  final UserSource _source;

  UserService(this._source) {
    assert(_source != null);
  }

  Future<List<User>> getUserList() async {
    final jsonString = await _source.getUserList();
    final resultList = _decodeUserList(jsonString);
    return resultList;
  }

  static List<User> _decodeUserList(JsonString jsonString) {
    final itemList = jsonString.decodedValue as List<dynamic>;
    return itemList.map((item) => User.fromJson(item)).toList();
  }
}
