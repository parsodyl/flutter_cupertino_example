import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<http.Response> get(url, {Map<String, String> headers});
  Future<void> close();

  factory HttpClient.mobile() {
    return HttpClientMobile._();
  }
}

class HttpClientMobile implements HttpClient {
  final _client = http.Client();

  HttpClientMobile._();

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) {
    return _client.get(url, headers: headers);
  }

  @override
  Future<void> close() async {
    return _client.close();
  }
}
