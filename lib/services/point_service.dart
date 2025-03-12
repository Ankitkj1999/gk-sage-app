import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/services/drift_service.dart';
import 'package:quiz_app/services/firebase_service.dart';

class PointsService {
  static final PointsService _instance = PointsService._internal();
  factory PointsService() => _instance;
  PointsService._internal();

  // Queue for pending point updates
  final List<PointUpdate> _pendingUpdates = [];
  bool _isSyncing = false;
  Timer? _syncTimer;

  // Initialize with periodic sync
  void initialize() {
    _syncTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      syncPointsToFirebase();
    });
  }

  void dispose() {
    _syncTimer?.cancel();
  }

  // Add points locally and queue for sync
  Future<void> addPoints(String userId, int pointsToAdd, String reason) async {
    if (pointsToAdd == 0) return;

    try {
      final DriftService driftService = DriftService();

      // Get current points from local database
      UserModel? user = await driftService.getUserData(userId);
      if (user == null) return;

      final int currentPoints = user.points ?? 0;
      final int newTotalPoints = currentPoints + pointsToAdd;

      // Update points in local database immediately
      await driftService.updateUserPoints(userId, newTotalPoints);

      // Format history entry
      String historyEntry = pointsToAdd.isNegative
          ? '$reason $pointsToAdd at ${DateTime.now()}'
          : '$reason +$pointsToAdd at ${DateTime.now()}';

      // Add history entry locally
      await driftService.addPointHistoryEntry(userId, historyEntry);

      // Queue the update for Firebase
      _pendingUpdates.add(PointUpdate(
        userId: userId,
        pointsToAdd: pointsToAdd,
        newTotal: newTotalPoints,
        reason: reason,
        timestamp: DateTime.now(),
      ));

      // Try to sync immediately, but don't wait for it
      syncPointsToFirebase();

    } catch (e) {
      debugPrint('Error adding points locally: $e');
    }
  }

  // Sync pending updates to Firebase
  Future<void> syncPointsToFirebase() async {
    // Avoid multiple concurrent syncs
    if (_isSyncing || _pendingUpdates.isEmpty) return;

    _isSyncing = true;

    try {
      // Take all pending updates
      final updates = List<PointUpdate>.from(_pendingUpdates);
      _pendingUpdates.clear();

      // Group updates by user
      final Map<String, List<PointUpdate>> userUpdates = {};
      for (var update in updates) {
        if (!userUpdates.containsKey(update.userId)) {
          userUpdates[update.userId] = [];
        }
        userUpdates[update.userId]!.add(update);
      }

      // Process each user's updates
      for (var userId in userUpdates.keys) {
        final updates = userUpdates[userId]!;

        // Calculate the total points to add and get the latest total
        int totalPoints = 0;
        int finalTotal = 0;
        List<String> history = [];

        for (var update in updates) {
          totalPoints += update.pointsToAdd;
          finalTotal = update.newTotal; // The last update has the final total

          // Format history entry
          String historyEntry = update.pointsToAdd.isNegative
              ? '${update.reason} ${update.pointsToAdd} at ${update.timestamp}'
              : '${update.reason} +${update.pointsToAdd} at ${update.timestamp}';
          history.add(historyEntry);
        }

        // Update Firebase in one go
        await FirebaseService().updateUserPoints(userId, finalTotal);

        // Add history entries
        for (var entry in history) {
          await FirebaseService().updateUserPointHistory(userId, entry);
        }
      }
    } catch (e) {
      debugPrint('Error syncing points to Firebase: $e');
      // Put failed updates back in the queue
      // In a production app, you'd want to be more sophisticated here
    } finally {
      _isSyncing = false;
    }
  }

  // Force immediate sync and wait for completion
  Future<void> forceSyncNow() async {
    await syncPointsToFirebase();
  }
}

// Model for a pending point update
class PointUpdate {
  final String userId;
  final int pointsToAdd;
  final int newTotal;
  final String reason;
  final DateTime timestamp;

  PointUpdate({
    required this.userId,
    required this.pointsToAdd,
    required this.newTotal,
    required this.reason,
    required this.timestamp,
  });
}