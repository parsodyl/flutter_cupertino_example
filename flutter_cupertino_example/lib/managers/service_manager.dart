import 'package:flutter_cupertino_example/data/clients/http_client.dart';
import 'package:flutter_cupertino_example/data/services/user_service.dart';
import 'package:flutter_cupertino_example/data/sources/user_source.dart';

class ServiceManager {
  static final ServiceManager _singleton = ServiceManager._();
  ServiceManager._();
  static ServiceManager get instance => _singleton;

  // clients
  final httpClient = HttpClient.mobile();

  // user service
  UserService _userService;
  UserService get userService {
    if (_userService == null) {
      _userService = UserService(UserSourceWeb(httpClient));
    }
    return _userService;
  }

  // close all clients
  void closeClients() {
    httpClient.close();
  }
}
