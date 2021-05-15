import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/user.dart';
import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authenticating = false;

  final _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    this.authenticating = true;
    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('${Enviroment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );

    this.authenticating = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    }
    return false;
  }

  Future register(String name, String email, String password) async {
    this.authenticating = true;
    final Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('${Enviroment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'content-type': 'application/json'},
    );

    this.authenticating = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    }
    final body = jsonDecode(response.body);
    return body['msg'];
  }

  bool get authenticating => this._authenticating;
  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: 'token') ?? '';
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('${Enviroment.apiUrl}/login/renew'),
      headers: {
        'content-type': 'application/json',
        'x-token': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      this.user = loginResponse.user;
      this._saveToken(loginResponse.token);
      return true;
    }
    this.logout();
    return false;
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
