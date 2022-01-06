import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
   String? _userId;
   DateTime? _expireDate;
  // Timer _authTimer;

  String? get token {
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  dynamic? get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> UserRegister(String email, String password,String name ,String confirmPassword) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAoaPH9ktPt3rytwBOATAJ8TrPQVH9yyak';

    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expireDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    print(json.decode(response.body));
    notifyListeners();
  }

  Future<void> UserLogin(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAoaPH9ktPt3rytwBOATAJ8TrPQVH9yyak';

    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expireDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    print(json.decode(response.body));
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expireDate = null;
    // if (_authTimer != null) {
    //   //_authTimer!.cancel();
    //   //_authTimer = null;
    // }
    notifyListeners();
    //final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    //prefs.clear();
  }

}


