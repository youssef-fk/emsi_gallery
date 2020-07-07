import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_profile/user_profile.dart';

abstract class AuthService {
  Future<FirebaseUser> loginWithGoogle();
  Future<bool> get isLoggedIn;
  Future<UserProfile> get userProfile;
  Future<FirebaseUser> get firebaseUser;

  Future<void> saveUserProfile(UserProfile userProfile);
}

class AuthServiceImpl implements AuthService {
  final SharedPreferences sharedPreferences;

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  AuthServiceImpl({
    @required this.sharedPreferences,
  });

  Future<FirebaseUser> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final user = (await _firebaseAuth.signInWithCredential(credential)).user;

      return user;
    } on Exception {
      return null;
    }
  }

  @override
  Future<bool> get isLoggedIn async {
    final user = await _firebaseAuth.currentUser();
    return user != null;
  }

  @override
  Future<void> saveUserProfile(UserProfile userProfile) async {
    await sharedPreferences.setString(
      'user_profile',
      json.encode(userProfile.toJson()),
    );
  }

  @override
  Future<UserProfile> get userProfile async {
    final userString = sharedPreferences.getString('user_profile');

    if (userString == null) {
      return null;
    }

    return UserProfile.fromJson(
      json.decode(userString),
    );
  }

  @override
  Future<FirebaseUser> get firebaseUser => _firebaseAuth.currentUser();
}
