import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future _login(String email, String password, String urlSegment) async {
    final url =
        Uri.parse('https://suffer-mental-health-app.herokuapp.com/$urlSegment');
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({'email': email, 'password': password}));

      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      return responseData;
    } catch (err) {
      return err;
    }
  }

  Future _register(
      String email, String password, String name, String urlSegment) async {
    final url =
        Uri.parse('https://suffer-mental-health-app.herokuapp.com/$urlSegment');
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json
              .encode({'email': email, 'password': password, 'name': name}));
      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      return responseData;
    } catch (err) {
      return err;
    }
  }

  Future login(String email, String password) async {
    return _login(email, password, 'loginapi');
  }

  Future register(String email, String password, String name) async {
    return _register(email, password, name, 'resigterapi');
  }
}
