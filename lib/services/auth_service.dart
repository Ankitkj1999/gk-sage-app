import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:quiz_app/services/sp_service.dart'; // Add this import

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final SPService _spService = SPService(); // Add this line

  // Helper method to save UID after successful auth
  Future<void> _saveUidToLocal() async {
    if (_firebaseAuth.currentUser != null) {
      await _spService.saveUidToLocal(_firebaseAuth.currentUser!.uid);
      debugPrint('UID saved to local storage: ${_firebaseAuth.currentUser!.uid}');
    }
  }

  Future<UserCredential?> loginWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _saveUidToLocal(); // Save UID after successful login
      return credential;
    } catch (e) {
      debugPrint('Email login error: $e');
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null;
    }
    try {
      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      await _saveUidToLocal(); // Save UID after successful login
      return userCredential;
    } catch (e) {
      debugPrint('Google sign in error: $e');
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    return null;
    // When you implement this later, add _saveUidToLocal() after successful auth
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      await _saveUidToLocal(); // Save UID after successful login
      return userCredential;
    } catch (e) {
      debugPrint('Apple sign in error: $e');
      return null;
    }
  }

  Future userLogOut() async {
    try {
      if (user != null) {
        // Clear the UID from local storage before signing out
        await _spService.clearLocalData();
        await _firebaseAuth.signOut();
      } else {
        debugPrint('Not signed in');
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future googleLogout() async {
    try {
      final bool isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.signOut();
      }
    } catch (e) {
      debugPrint('Google logout error: $e');
    }
  }

  Future<UserCredential?> signUpWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _saveUidToLocal(); // Save UID after successful registration
      return credential;
    } catch (e) {
      debugPrint('Email signup error: $e');
      return null;
    }
  }

  Future deleteUserAuth() async {
    try {
      if (user != null) {
        // Clear the UID from local storage before deleting account
        await _spService.clearLocalData();
        await user?.delete().catchError((e) {
          debugPrint('error on deleting account');
          Fluttertoast.showToast(msg: e).toString();
        });
      }
    } catch (e) {
      debugPrint('Delete user error: $e');
    }
  }
}