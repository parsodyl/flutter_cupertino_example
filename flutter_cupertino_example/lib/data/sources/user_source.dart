import 'package:flutter/foundation.dart';
import 'package:flutter_cupertino_example/data/clients/http_client.dart';
import 'package:flutter_cupertino_example/data/errors/web_exceptions.dart';
import 'package:json_string/json_string.dart';

abstract class UserSource {
  Future<JsonString> getUserList();
}

class UserSourceWeb implements UserSource {
  HttpClient _httpClient;

  UserSourceWeb(this._httpClient) {
    assert(_httpClient != null);
  }

  @override
  Future<JsonString> getUserList() async {
    final response = await _httpClient.get(_buildGetUserListUrl());
    if (response.statusCode == 401) {
      throw UnauthorizedException(response.body);
    }
    if (response.statusCode == 404) {
      throw NotFoundException(response.body);
    }
    if (response.statusCode != 200) {
      throw BadResponseException(response.body);
    }
    return compute(_constructJsonString, response.body);
  }

  String _buildGetUserListUrl() => 'https://jsonplaceholder.typicode.com/users';

  static JsonString _constructJsonString(String responseBody) {
    return JsonString(responseBody, enableCache: true);
  }
}
