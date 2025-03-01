import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/blocs/ads_bloc.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/configs/app_config.dart';
import 'package:quiz_app/utils/icon_utils.dart';
import 'package:quiz_app/widgets/loading_widget.dart';
import 'package:quiz_app/services/firebase_service.dart';
import '../configs/ad_config.dart';


Future<void> openAnimationDialog(context, String animationString, String title, String subtitle) {
  return Dialogs.materialDialog(
    actionsBuilder: (context) => [
      _buildRewardedAdButton(context),
    ],
    context: context,
     customView: Stack(
      alignment: Alignment.topRight,
       children: [
        Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LottieBuilder.asset(
                  animationString,
                  fit: BoxFit.contain,
                ),
              ),

            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
         ),
  );
}

Widget _buildRewardedAdButton(BuildContext context) {
  bool _isLoading = false;
  RewardedAd? _rewardedAd;

  // Create a stateful builder to manage the loading state
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        // Create rewarded video ad function
        void _createRewardedVideoAd() async {
          setState(() => _isLoading = true);
          await RewardedAd.load(
              adUnitId: AdConfig.getRewardedVideoAdUnitId(),
              request: const AdRequest(),
              rewardedAdLoadCallback: RewardedAdLoadCallback(
                onAdLoaded: (RewardedAd ad) {
                  debugPrint('$ad loaded');
                  _rewardedAd = ad;
                  _showRewardedVideoAd(context, ad, setState);
                  setState(() => _isLoading = false);
                },
                onAdFailedToLoad: (LoadAdError error) {
                  debugPrint('Rewarded Ad failed to load: $error.');
                  _rewardedAd = null;
                  setState(() => _isLoading = false);
                },
              ));
        }

        // Return the actual button widget
        return InkWell(
          onTap: () {
            _createRewardedVideoAd();
          },
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5)),
            child: _isLoading
                ? const LoadingIndicatorWidget(
              color: Colors.white,
            )
                : Wrap(
              children: [
                const Icon(
                  IconUtils.video,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('earn-points',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white))
                    .tr(args: [context.read<AdsBloc>().rewardedAdPoints.toString()]),
              ],
            ),
          ),
        );
      }
  );
}

// void _showRewardedVideoAd(BuildContext context, RewardedAd ad, StateSetter setState) {
//   ad.fullScreenContentCallback = FullScreenContentCallback(
//     onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
//     onAdDismissedFullScreenContent: (RewardedAd ad) {
//       debugPrint('$ad onAdDismissedFullScreenContent.');
//       ad.dispose();
//     },
//     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//       debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//       ad.dispose();
//     },
//   );
//
//   ad.show(onUserEarnedReward: (ad, RewardItem item) async {
//     await _onRewardComplete(context);
//     // Close the dialog after reward is complete
//     Navigator.pop(context);
//   });
// }

// void _showRewardedVideoAd(BuildContext context, RewardedAd ad, StateSetter setState) {
//   ad.fullScreenContentCallback = FullScreenContentCallback(
//     onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
//     onAdDismissedFullScreenContent: (RewardedAd ad) {
//       debugPrint('$ad onAdDismissedFullScreenContent.');
//       ad.dispose();
//     },
//     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//       debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//       ad.dispose();
//     },
//   );
//
//   ad.show(onUserEarnedReward: (ad, RewardItem item) async {
//     // First close the current dialog
//     Navigator.pop(context);
//
//     // Then process the reward and show the confirmation dialog
//     await _onRewardComplete(context);
//   });
// }
// void _showRewardedVideoAd(BuildContext context, RewardedAd ad, StateSetter setState) {
//   // Store the necessary data before showing the ad
//   final String userId = context.read<UserBloc>().userData!.uid!;
//   final int rewardAmount = context.read<AdsBloc>().rewardedAdPoints;
//
//   ad.fullScreenContentCallback = FullScreenContentCallback(
//     onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
//     onAdDismissedFullScreenContent: (RewardedAd ad) {
//       debugPrint('$ad onAdDismissedFullScreenContent.');
//       ad.dispose();
//     },
//     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//       debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//       ad.dispose();
//     },
//   );
//
//   ad.show(onUserEarnedReward: (ad, RewardItem item) async {
//     // Close the current dialog
//     Navigator.pop(context);
//
//     // Use a future to ensure the dialog is fully closed
//     // before we try to handle the reward and show the new dialog
//     Future.delayed(Duration(milliseconds: 300), () async {
//       // Update user points with stored data
//       await FirebaseService().updateUserPointsByTransection(userId, true, rewardAmount);
//
//       // Update history with stored data
//       final newHistory = "Watched A Rewarded Video Ad +$rewardAmount at ${DateTime.now()}";
//       await FirebaseService().updateUserPointHistory(userId, newHistory);
//
//       // Refresh user data
//       await context.read<UserBloc>().getUserData();
//
//       // Show the claim dialog with a valid context
//       _openRewardDialog(context, rewardAmount);
//     });
//   });
// }
void _showRewardedVideoAd(BuildContext context, RewardedAd ad, StateSetter setState) {
  // Store all the necessary data and references
  final UserBloc userBloc = context.read<UserBloc>();
  final String userId = userBloc.userData!.uid!;
  final int rewardAmount = context.read<AdsBloc>().rewardedAdPoints;
  // Store the navigator state to use later
  final NavigatorState navigator = Navigator.of(context);

  ad.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (RewardedAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (RewardedAd ad) {
      debugPrint('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
    },
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
      debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
    },
  );

  ad.show(onUserEarnedReward: (ad, RewardItem item) async {
    // Close the current dialog
    navigator.pop();

    // Handle rewards without using context
    await _handleReward(navigator, userId, rewardAmount, userBloc);
  });
}

// Create a separate function that doesn't rely on BuildContext for Provider access
Future<void> _handleReward(NavigatorState navigator, String userId, int rewardAmount, UserBloc userBloc) async {
  // Update user points with stored data
  await FirebaseService().updateUserPointsByTransection(userId, true, rewardAmount);

  // Update history with stored data
  final newHistory = "Watched A Rewarded Video Ad +$rewardAmount at ${DateTime.now()}";
  await FirebaseService().updateUserPointHistory(userId, newHistory);

  // Refresh user data using the stored bloc
  await userBloc.getUserData();

  // Show reward dialog using navigator's context
  _showRewardDialogWithNavigator(navigator, rewardAmount);
}

// Show the reward dialog using navigator's context
Future<void> _showRewardDialogWithNavigator(NavigatorState navigator, int rewardAmount) {
  return Dialogs.materialDialog(
    context: navigator.context, // Use navigator's context which is always valid
    title: 'points-reward-title'.tr(),
    msg: 'points-reward-subtitle-count'.tr(args: [rewardAmount.toString()]),
    lottieBuilder: LottieBuilder.asset(
      Config.rewardAnimation,
      fit: BoxFit.cover,
    ),
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    msgAlign: TextAlign.center,
    msgStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    actionsBuilder: (context) => [
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        child: IconsButton(
          onPressed: () => navigator.pop(),
          text: 'claim'.tr(),
          iconData: Icons.done,
          color: Theme.of(context).primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          iconColor: Colors.white,
        ),
      ),
    ],
  );
}


Future<void> _onRewardComplete(BuildContext context) async {
  final String userId = context.read<UserBloc>().userData!.uid!;
  final int rewardAmount = context.read<AdsBloc>().rewardedAdPoints;
  await FirebaseService()
      .updateUserPointsByTransection(userId, true, rewardAmount)
      .then((value) async => await _updatePointsHistory(context, rewardAmount))
      .then((value) async => await context.read<UserBloc>().getUserData());
  _openRewardDialog(context, rewardAmount);
}

Future<void> _updatePointsHistory(BuildContext context, int rewardPoint) async {
  final String userId = context.read<UserBloc>().userData!.uid!;
  final newHistory = "Watched A Rewarded Video Ad +$rewardPoint at ${DateTime.now()}";
  await FirebaseService().updateUserPointHistory(userId, newHistory);
}

Future<void> _openRewardDialog(BuildContext context, int rewardAmount) {
  return Dialogs.materialDialog(
    context: context,
    title: 'points-reward-title'.tr(),
    msg: 'points-reward-subtitle-count'.tr(args: [rewardAmount.toString()]),
    lottieBuilder: LottieBuilder.asset(
      Config.rewardAnimation,
      fit: BoxFit.cover,
    ),
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    msgAlign: TextAlign.center,
    msgStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    actionsBuilder: (context) => [
      Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        child: IconsButton(
          onPressed: () => Navigator.pop(context),
          text: 'claim'.tr(),
          iconData: Icons.done,
          color: Theme.of(context).primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          iconColor: Colors.white,
        ),
      ),
    ],
  );
}