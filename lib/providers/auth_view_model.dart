import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/model/user_model.dart';
import '../repo/auth_repo.dart';
import '../services/firebase_service.dart';

class AuthViewModel with ChangeNotifier {

  User? _user = FirebaseService.firebaseAuth.currentUser;

  User? get user => _user;

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  Future<void> login(String email, String password) async {
    try {
      var response = await AuthRepository().login(email, password);
      _user = response.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid, _token);
      notifyListeners();
    } catch (err) {
      AuthRepository().logout();
      rethrow;
    }
  }



  Future<void> register(UserModel user) async {
    try {
      var response = await AuthRepository().register(user);
      _user = response!.user;
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid, _token);
      notifyListeners();
    } catch (err) {
      AuthRepository().logout();
      rethrow;
    }
  }

  String? _token;
  String? get token => _token;
  Future<void> checkLogin(String? token) async {
    try {
      _loggedInUser = await AuthRepository().getUserDetail(_user!.uid, token);
      _token = token;
      notifyListeners();
    } catch (err) {
      _user = null;
      AuthRepository().logout();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await AuthRepository().logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

}