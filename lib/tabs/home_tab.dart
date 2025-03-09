import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/ads_bloc.dart';
import 'package:quiz_app/blocs/settings_bloc.dart';
import 'package:quiz_app/blocs/tab_controller.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/configs/app_config.dart';
import 'package:quiz_app/configs/color_config.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/pages/notifications.dart';
import 'package:quiz_app/pages/self_challenge.dart';
import 'package:quiz_app/pages/settings.dart';
import 'package:quiz_app/services/drift_service.dart';
import 'package:quiz_app/tabs/leaderboard_tab.dart';
import 'package:quiz_app/utils/icon_utils.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/widgets/avatar_circle.dart';
import 'package:quiz_app/widgets/custom_chip.dart';
import 'package:quiz_app/widgets/rewarded_ad_container.dart';
import '../models/category.dart';
import '../services/MultipleCubesPainterService.dart';
import '../services/cubes_backgound_service.dart';
import '../services/greeting_service.dart';
import '../widgets/home_categories.dart';
import '../widgets/featured.dart';
import '../widgets/sp_category1.dart';
import '../widgets/sp_category2.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  final DriftService _driftService = DriftService();
  bool _isSyncing = false;
  List<Quiz> _localQuizzes = [];
  List<Category> _localCategorys = [];
  List<Question> _localQuestions = [];
  

  @override
  void initState() {
    super.initState();
    _syncData();
  }

  Future<void> _syncData() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      // First sync categories and quizzes (this is quick)
      _localCategorys = await _driftService.syncAndGetAllCategories();
      _localQuizzes = await _driftService.syncAndGetAllQuizzes();

      setState(() {
        _isSyncing = false;
      });

      // Then sync questions in the background (can take longer)
      // This runs after setting isSyncing to false so the UI is responsive
      _startBackgroundQuestionSync();

    } catch (e) {
      setState(() {
        _isSyncing = false;
      });
      debugPrint('Error syncing data: $e');
    }
  }

  void _startBackgroundQuestionSync() {
    // This doesn't block the UI since it's not awaited
    _driftService.syncQuestionsForAllQuizzes().then((_) {
      // Optionally update state if needed when sync completes
      if (mounted) {
        setState(() {
          // You could set a flag to show sync is complete
        });
      }
    });
  }

  @override
  void dispose() {
    _driftService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.read<SettingsBloc>();
    final ab = context.read<AdsBloc>();
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopBar(),
                Column(
                  children: [
                    const FeaturedCategories(),
                    const HomeCategories(),
                    sb.specialCategory.enabled ?? false
                        ? SpecialCategory1(catID: sb.specialCategory.id1.toString())
                        : const SizedBox.shrink(),
                    const SizedBox(height: 30),
                    sb.specialCategory.enabled ?? false
                        ? SpecialCategory2(catID: sb.specialCategory.id2.toString())
                        : const SizedBox.shrink(),
                    sb.selfChallengeModeEnabled
                        ? const _SelfChallengeContainer()
                        : const SizedBox.shrink(),
                    ab.isRewardedEnabled
                        ? const RewardedAdContainer()
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
          // Show loading indicator when syncing
          if (_isSyncing)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Keep existing _SelfChallengeContainer and _TopBar classes unchanged
class _SelfChallengeContainer extends StatelessWidget {
  const _SelfChallengeContainer();

  @override
  Widget build(BuildContext context) {
    // Existing implementation...
    return InkWell(
      onTap: () => NextScreen.nextScreenNormal(
          context,
          const SelfChallengePage(
            imageString: Config.selfChallengeCoverImage,
          )),
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'self-challenge-mode',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ).tr()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Config.selfChallengeCoverImage)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'challenge-yourself',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ).tr(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white60,
                        )),
                    child: Text(
                      'play-now',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ).tr(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBloc>().userData;
    final int rank = context.watch<UserBloc>().userRank;

    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff7254FF),
                  Color(0xff7254FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          CustomPaint(
            size: const Size(double.infinity, 140),
            painter: CachedCubesPainter(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                GreetingService.getGreeting(context),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium,
                              ).tr(),
                              const SizedBox(width: 5),
                              LottieBuilder.asset(
                                Config.hiAnimation,
                                height: 25,
                                width: 25,
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      AvatarGlow(
                        glowCount: 1,
                        animate: true,
                        repeat: true,
                        glowRadiusFactor: 0.2,
                        child: InkWell(
                          onTap: () =>
                              context.read<TabControllerBloc>().controlTab(2),
                          child: AvatarCircle(
                            assetString: user.avatarString,
                            imageUrl: user.imageUrl,
                            size: 60,
                            bgColor: ColorConfig.avatarBg4,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      InkWell(
                        child: CustomChip1(
                          label: user.points.toString(),
                          icon: IconUtils.coins,
                          bgColor: ColorConfig.chip1,
                        ),
                        onTap: () =>
                            context.read<TabControllerBloc>().controlTab(2),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: CustomChip1(
                          label: '#$rank',
                          icon: IconUtils.leaderboard1,
                          bgColor: ColorConfig.chip2,
                        ),
                        onTap: () => NextScreen.nextScreenNormal(
                            context, const LeaderboardTab()),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => NextScreen.nextScreenNormal(
                            context, const Notifications()),
                        child: CircleAvatar(
                          backgroundColor: ColorConfig.iconBg,
                          child: const Icon(
                            IconUtils.bell,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => NextScreen.nextScreenNormal(
                            context, const SettingsPage()),
                        child: CircleAvatar(
                          backgroundColor: ColorConfig.iconBg,
                          child: const Icon(
                            IconUtils.settings,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}