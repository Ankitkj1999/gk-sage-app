import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/services/drift_service.dart';
import 'package:quiz_app/services/firebase_service.dart';
import 'package:quiz_app/services/sp_service.dart';

class UserBloc extends ChangeNotifier {
  UserModel? _userData;
  UserModel? get userData => _userData;

  int _userRank = 0;
  int get userRank => _userRank;

  final DriftService _driftService = DriftService();
  final SPService _spService = SPService();

  UserBloc() {
    getUserRank();
    // Initialize user data as soon as the bloc is created
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    // Try to get cached user data immediately
    String? uid = await _spService.getUidFromLocal();
    if (uid != null) {
      // First try to get from local database
      await _getLocalUserData(uid);

      // Then refresh from Firebase in the background
      _refreshFromFirebase(uid);
    }
  }

  // Get user data from local Drift database
  Future<void> _getLocalUserData(String uid) async {
    try {
      debugPrint('Attempting to get user data from local database...');
      UserModel? localUser = await _driftService.getUserData(uid);

      if (localUser != null) {
        _userData = localUser;
        debugPrint('User data loaded from local database');
        notifyListeners();
      } else {
        debugPrint('No user data found in local database');
      }
    } catch (e) {
      debugPrint('Error getting local user data: $e');
    }
  }

  // Refresh data from Firebase in the background
  Future<void> _refreshFromFirebase(String uid) async {
    try {
      debugPrint('Refreshing user data from Firebase...');
      UserModel? firebaseUser = await _driftService.syncAndGetUserData(uid);

      if (firebaseUser != null && (
          _userData == null ||
              firebaseUser.updatedAt?.seconds != _userData?.updatedAt?.seconds)) {
        _userData = firebaseUser;
        debugPrint('User data updated from Firebase');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error refreshing from Firebase: $e');
    }
  }

  // Public method to get user data (supports both online and offline)
  Future<void> getUserData() async {
    String? uid = await _spService.getUidFromLocal();

    if (uid != null) {
      // First check local database
      await _getLocalUserData(uid);

      // Then refresh from Firebase
      await _refreshFromFirebase(uid);
    } else {
      // Fallback to direct Firebase if no UID in local storage
      await FirebaseService().getUserData().then((UserModel? userModel) async {
        if (userModel != null && userModel.uid != null) {
          _userData = userModel;

          // Save UID for future use
          await _spService.saveUidToLocal(userModel.uid!);

          // Save to local database
          await _driftService.syncAndGetUserData(userModel.uid!);

          debugPrint('User data fetched directly from Firebase');
          notifyListeners();
        }
      });
    }
  }

  void setUserData(UserModel userData) {
    _userData = userData;
    notifyListeners();
  }

  Future<void> setUserRank(int newRank) async {
    await _spService.saveRankToLocal(newRank);
    _userRank = newRank;
    notifyListeners();
  }

  Future<void> updateUserPointsToBloc(int newPoints) async {
    if (_userData != null && _userData!.uid != null) {
      _userData!.points = newPoints;

      // Also update local database
      await _driftService.updateUserPoints(_userData!.uid!, newPoints);

      notifyListeners();
    }
  }

  Future<void> getUserRank() async {
    await _spService.getUserRank().then((int rank) {
      _userRank = rank;
      notifyListeners();
    });
  }

  Future<void> clearUserData() async {
    await _spService.clearLocalData();
    _userRank = 0;
    _userData = null;
    notifyListeners();
  }
}