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
import 'package:quiz_app/pages/notifications.dart';
import 'package:quiz_app/pages/self_challenge.dart';
import 'package:quiz_app/pages/settings.dart';
import 'package:quiz_app/tabs/leaderboard_tab.dart';
import 'package:quiz_app/utils/icon_utils.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/widgets/avatar_circle.dart';
import 'package:quiz_app/widgets/custom_chip.dart';
import 'package:quiz_app/widgets/rewarded_ad_container.dart';
// import '../IAP/iap_config.dart';
// import '../IAP/iap_page.dart';
import '../services/MultipleCubesPainterService.dart';
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
      body: SingleChildScrollView(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SelfChallengeContainer extends StatelessWidget {
  const _SelfChallengeContainer();

  @override
  Widget build(BuildContext context) {
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

// class _TopBar extends StatelessWidget {
//   const _TopBar();
//
//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<UserBloc>().userData;
//     final int rank = context.watch<UserBloc>().userRank;
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 10, 10, 15),
//       height: 140,
//       decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           // 'welcome-back',
//                           GreetingService.getGreeting(context),
//                           style: Theme.of(context).primaryTextTheme.bodyMedium,
//                         ).tr(),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         //Image.asset(Config.hiEmoji, width: 25, height: 25,)
//                         LottieBuilder.asset(
//                           Config.hiAnimation,
//                           height: 25,
//                           width: 25,
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       user!.name!,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 AvatarGlow(
//                   glowCount: 1,
//                   animate: true,
//                   repeat: true,
//                   glowRadiusFactor: 0.2,
//                   child: InkWell(
//                     onTap: () => context.read<TabControllerBloc>().controlTab(2),
//                     child: AvatarCircle(assetString: user.avatarString, imageUrl: user.imageUrl, size: 60, bgColor: ColorConfig.avatarBg4),
//                   ),
//                 )
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 InkWell(
//                   child: CustomChip1(label: user.points.toString(), icon: IconUtils.starFill, bgColor: ColorConfig.chip1),
//                   onTap: () => context.read<TabControllerBloc>().controlTab(2),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   child: CustomChip1(label: '#$rank', icon: IconUtils.leaderboard1, bgColor: ColorConfig.chip2),
//                   onTap: () => NextScreen.nextScreenNormal(context, const LeaderboardTab()),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   onTap: () => NextScreen.nextScreenNormal(context, const Notifications()),
//                   child: CircleAvatar(
//                     backgroundColor: ColorConfig.iconBg,
//                     child: const Icon(
//                       IconUtils.bell,
//                       size: 22,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   onTap: () => NextScreen.nextScreenNormal(context, const SettingsPage()),
//                   child: CircleAvatar(
//                     backgroundColor: ColorConfig.iconBg,
//                     child: const Icon(
//                       IconUtils.settings,
//                       size: 22,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 // Visibility(
//                 //   visible: IAPConfig.iAPEnabled,
//                 //   child: InkWell(
//                 //     onTap: () => NextScreen.nextScreenNormal(context, const IAPScreen()),
//                 //     child: CircleAvatar(
//                 //       backgroundColor: ColorConfig.iconBg,
//                 //       child: const Icon(
//                 //         IconUtils.store,
//                 //         size: 22,
//                 //         color: Colors.white,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBloc>().userData;
    final int rank = context.watch<UserBloc>().userRank;

    return SizedBox(
      height: 140, // The total height of your top bar
      child: Stack(
        children: [
          // 1) Background gradient
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

          // 2) Cubes painter
          // Use the same size as your top bar so cubes fill the area
          CustomPaint(
            size: const Size(double.infinity, 140),
            painter: MultipleCubesPainterService(),
          ),

          // 3) Foreground UI (your existing _TopBar content)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Row with greeting, user name, avatar glow ---
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
                  // --- Row with points, rank, notifications, settings, etc. ---
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
                      // Additional icons or store, if needed
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
