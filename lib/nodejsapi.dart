import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NeusHubNodeAPI {
  final String host;
  final int port;
  final bool secured;
  final SharedPreferences? preferences;

  NeusHubNodeAPI(
    this.host, {
    this.port = 80,
    this.secured = true,
    this.preferences,
  });

  final Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Uri uri(String path, [String query = '']) {
    return Uri.parse(
      'http${(secured) ? 's' : ''}://$host/$path${(query == '') ? '' : ('?$query')}',
    );
  }

  String image(String imageName, [String path = 'images']) {
    return '${uri('')}$path/$imageName';
  }

  Future<int> connection([String path = '']) async {
    late http.Response response;

    try {
      response = await http.get(uri(''), headers: headers);
      if (response.statusCode != 200) {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }

    return response.statusCode;
  }

  Future<dynamic> signUp(
    String email,
    String fullName,
    String password,
  ) async {
    http.Response response = await http.post(
      uri('signup'),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'full_name': fullName,
        'password': password,
      }),
    );

    return jsonDecode(response.body)[0];
  }

  Future<dynamic> signIn(
    String email,
    String password, [
    String ip = '',
    bool remember = false,
  ]) async {
    http.Response response = await http.post(
      uri(
        'signin',
      ),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
        'ip': ip,
      }),
    );

    if (jsonDecode(response.body)[0] != 'user not found' &&
        jsonDecode(response.body)[0] != 'password not match' &&
        remember) {
      preferences?.setString('token', jsonDecode(response.body)[0]['token']);
      preferences?.setString('email', email);
    }

    return switch (jsonDecode(response.body)[0]) {
      'user not found' => jsonDecode(response.body)[0],
      'password not match' => jsonDecode(response.body)[0],
      _ => jsonDecode(response.body)[0],
    };
  }

  Future<dynamic> token() async {
    http.Response response = await http.get(uri(
      'token',
      'e=${preferences?.getString('email') ?? ''}&t=${preferences?.getString('token') ?? ''}',
    ));

    return jsonDecode(response.body);
  }

  Future<dynamic> posts() async {
    http.Response response = await http.get(uri('posts'));

    return jsonDecode(response.body);
  }

  Future<dynamic> getData(String email, [String path = 'userdata']) async {
    http.Response response = await http.get(uri(path, 'email=$email'));

    return jsonDecode(response.body);
  }

  Future<dynamic> subscribe(
    String otherUser, [
    String path = 'subscribe',
  ]) async {
    http.Response response = await http.get(uri(
      path,
      'e=${preferences?.getString('email') ?? ''}&other_user=$otherUser&t=${preferences?.getString('token') ?? ''}',
    ));

    return jsonDecode(response.body);
  }
}
