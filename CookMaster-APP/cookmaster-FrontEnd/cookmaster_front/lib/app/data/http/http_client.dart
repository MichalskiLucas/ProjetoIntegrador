import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future getAllIngredients({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future getAllIngredients({required String url}) async {
    return await client.get(Uri.parse(url));
  }
}
