import 'package:http/http.dart' as http;

abstract class RemoteService {
  Future<http.Response> get(String url);
  Future<http.Response> post(String url, {dynamic body});
  Future<http.Response> put(String url, {dynamic body});
}

class RemoteServiceImpl implements RemoteService {
  @override
  Future<http.Response> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<http.Response> post(String url, {body}) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<http.Response> put(String url, {body}) async {
    try {
      final response = await http.put(Uri.parse(url), body: body);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
