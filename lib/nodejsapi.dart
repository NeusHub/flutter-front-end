import 'dart:convert';

import 'package:http/http.dart' as http;

class NeusHubNodeAPI {
  final String host;
  final int port;
  final bool secured;

  const NeusHubNodeAPI(
    this.host, {
    this.port = 80,
    this.secured = true,
  });

  Future<int> connection([String path = '']) async {
    Uri uri = Uri.parse(
      'http${(secured) ? 's' : ''}://$host/$path',
    );
    late http.Response response;

    try {
      response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }

    return response.statusCode;
  }

  Future<void> signUp() async {
    Uri uri = Uri.parse(
      'http${(secured) ? 's' : ''}://$host/signup',
    );

    await http.post(
      uri,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': 'jo@jo.jo',
        'full_name': 'jo',
        'password': 'jo',
      }),
    );
  }
}
