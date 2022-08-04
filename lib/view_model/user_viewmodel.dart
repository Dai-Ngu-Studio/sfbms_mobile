import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sfbms_mobile/data/models/user.dart' as user_model;
import 'package:sfbms_mobile/data/remote/app_exception.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/user_repository_impl.dart';

class UserViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _userRepo = UserRepositoryImpl();
  GoogleSignInAccount? _googleUser;

  ApiResponse<user_model.User> user = ApiResponse.loading();

  GoogleSignInAccount get googleUser => _googleUser!;

  bool get isAuth {
    return _firebaseAuth.currentUser != null;
  }

  Future<String?> get idToken async {
    return await _firebaseAuth.currentUser?.getIdToken();
  }

  String? get userPhotoURL => _firebaseAuth.currentUser?.photoURL;

  void _setAccount(ApiResponse<user_model.User> response) {
    log(response.toString());
    user = response;
  }

  Future<bool> login() async {
    try {
      final isAuth = await _loginGoogle();

      if (!isAuth) {
        _setAccount(ApiResponse.error("Login failed"));
        return false;
      }

      _setAccount(ApiResponse.loading());

      var user = await _userRepo.login(idToken: (await idToken)!);

      _setAccount(ApiResponse.completed(user));

      return true;
    } on FetchDataException catch (_) {
      await logout();
      rethrow;
    } catch (_) {
      await logout();
      rethrow;
    }
  }

  Future<bool> _loginGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      await logout();

      final googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) return false;

      _googleUser = googleAccount;

      final googleAuth = await googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      log((await idToken)!);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception('This email already has an account');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid Credential');
      } else if (e.code == 'user-disabled') {
        throw Exception('User Disabled');
      }
    } catch (_) {
      rethrow;
    }

    return false;
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (_) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
