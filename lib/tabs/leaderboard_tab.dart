import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/configs/color_config.dart';
import 'package:quiz_app/configs/feature_config.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/public_profile.dart';
import 'package:quiz_app/services/firebase_service.dart';
import 'package:quiz_app/utils/icon_utils.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/widgets/avatar_circle.dart';
import 'package:quiz_app/widgets/loading_widget.dart';

import '../services/v_pattern_background.dart';
import '../widgets/podium_widget.dart'; // Import the new Podium widget

class LeaderboardTab extends StatefulWidget {
  const LeaderboardTab({super.key});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  late Future _userData;
  final double _topHeaderHeight = 450; // Increased to accommodate podium
  final int _totalUserforLeaderboard = 30;

  @override
  void initState() {
    _userData = _getData();
    super.initState();
  }

  _onRefresh() async {
    setState(() {});
    _userData = _getData();
  }

  Future<List<UserModel>> _getData() async {
    List<UserModel> data = [];
    await FirebaseService()
        .getTopUsersData(_totalUserforLeaderboard)
        .then((List<UserModel> userList) {
      int index = userList.indexWhere(
              (element) => element.uid == context.read<UserBloc>().userData!.uid);
      int rank = index + 1;
      context.read<UserBloc>().setUserRank(rank);
      debugPrint('rank: $rank');
      data = userList;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'leaderboard',
          style: TextStyle(color: Colors.white),
        ).tr(),
        automaticallyImplyLeading: true,
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          IconButton(
              onPressed: () async => await _onRefresh(),
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: CustomPaint(

              painter: VPatternPainter(
                backgroundColor: ColorConfig.appThemeColor,
                // backgroundColor: Color(0xFF7D62FF),
                patternColor: Color(0xFF9A84FF),
                // patternHeight: 70.0,
              ),

            child: FutureBuilder(
              future: _userData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Column(
                    children: [
                      Container(
                        height: _topHeaderHeight,
                        color: Theme.of(context).primaryColor,
                        child: const LoadingIndicatorWidget(color: Colors.white),
                      ),
                    ],
                  );
                }
                if (snapshot.hasData && snapshot.data.length != 0) {
                  List<UserModel> userList = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _topList(context, userList),
                      _bottomList(userList)
                    ],
                  );
                }

                return Column(
                  children: [
                    Container(
                      height: _topHeaderHeight,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Text('No Users Found',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white))),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  DelayedDisplay _bottomList(List<UserModel> userList) {
    return DelayedDisplay(
      delay: const Duration(milliseconds: 200),
      child: Container(
        color: Colors.transparent,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userList.length,
          separatorBuilder: ((context, index) {
            if (index <= 2) return Container();
            return const SizedBox(
              height: 15,
            );
          }),
          itemBuilder: (BuildContext context, int index) {
            if (index <= 2) return Container();
            return InkWell(
              onTap: () => NextScreen.openBottomSheet(context,
                  PublicProfile(user: userList[index], rank: index + 1)),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    isThreeLine: false,
                    title: Text(
                      userList[index].name!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                          fontSize: 18),
                    ),
                    trailing: Wrap(
                      children: [
                        const Icon(
                          IconUtils.starFill,
                          size: 18,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          userList[index].points.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                    subtitle: Visibility(
                      visible: FeatureConfig.userStrengthEnabled,
                      child: const Text('strength-count').tr(
                          args: [userList[index].strength!.toStringAsFixed(2)]),
                    ),
                    leading: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey.shade400),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.blueGrey),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        AvatarCircle(
                            assetString: userList[index].avatarString,
                            imageUrl: userList[index].imageUrl,
                            size: 50,
                            bgColor: ColorConfig.avatarBg3)
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
 
  Container _topList(BuildContext context, List<UserModel> userList) {
    // Podium block height values - these should match what's in the Podium widget
    final double podiumHeight = 200;
    final double firstPodiumHeight = podiumHeight * 0.75;
    final double secondPodiumHeight = podiumHeight * 0.55;
    final double thirdPodiumHeight = podiumHeight * 0.45;

    // Calculate vertical offsets for each position to match their respective podium heights
    final double firstOffset = 30; // Base offset for 1st place
    final double secondOffset = firstOffset + (firstPodiumHeight - secondPodiumHeight);
    final double thirdOffset = firstOffset + (firstPodiumHeight - thirdPodiumHeight);

    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
      height: _topHeaderHeight,
      decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
          )
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          // Podium layer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: podiumHeight,
            child: Podium(
              width: MediaQuery.of(context).size.width - 20,
              height: podiumHeight,
              showNumbers: true,
              backgroundColor: Colors.transparent,
            ),
          ),

          // 2nd place user
          if (userList.length >= 2)
            Positioned(
              bottom: secondPodiumHeight + secondOffset,
              left: 0,
              width: MediaQuery.of(context).size.width / 3,
              child: DelayedDisplay(
                delay: const Duration(milliseconds: 400),
                child: Column(
                  children: [
                    // Container to hold avatar+medal with proper spacing
                    Container(
                      height: 86, // Avatar size (70) + some space for medal
                      child: Stack(
                        clipBehavior: Clip.none, // Important: Allow medal to extend outside stack
                        children: [
                          // Avatar centered in the stack
                          Center(
                            child: InkWell(
                              onTap: () => NextScreen.openBottomSheet(context,
                                  PublicProfile(user: userList[1], rank: 2)),
                              child: AvatarCircle(
                                  assetString: userList[1].avatarString,
                                  imageUrl: userList[1].imageUrl,
                                  size: 70,
                                  bgColor: ColorConfig.avatarBg2),
                            ),
                          ),
                          // Medal positioned at bottom of avatar, but overlapping
                          Positioned(
                            bottom: -20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.asset(
                                'assets/icons/medal-2.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      userList[1].name!.split(" ").firstOrNull ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${userList[1].points} Pt",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 1st place user
          Positioned(
            bottom: firstPodiumHeight + firstOffset,
            left: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width / 3,
            child: DelayedDisplay(
              delay: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  // Container to hold avatar+medal with proper spacing
                  Container(
                    height: 108, // Avatar size (90) + some space for medal
                    child: Stack(
                      clipBehavior: Clip.none, // Allow medal to extend outside stack
                      children: [
                        // Avatar centered in the stack
                        Center(
                          child: InkWell(
                            onTap: () => NextScreen.openBottomSheet(
                                context, PublicProfile(user: userList[0], rank: 1)),
                            child: AvatarCircle(
                                assetString: userList[0].avatarString,
                                imageUrl: userList[0].imageUrl,
                                size: 90,
                                bgColor: ColorConfig.avatarBg2),
                          ),
                        ),
                        // Medal positioned at bottom of avatar, but overlapping
                        Positioned(
                          bottom: -20,
                          left: 0,
                          right: 0,
                           child: Center(
                            child: Image.asset(
                              'assets/icons/medal-1.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    userList[0].name!.split(" ").firstOrNull!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${userList[0].points} Pt",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3rd place user
          if (userList.length >= 3)
            Positioned(
              bottom: thirdPodiumHeight + thirdOffset,
              right: 0,
              width: MediaQuery.of(context).size.width / 3,
              child: DelayedDisplay(
                delay: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    // Container to hold avatar+medal with proper spacing
                    Container(
                      height: 86, // Avatar size (70) + some space for medal
                      child: Stack(
                        clipBehavior: Clip.none, // Allow medal to extend outside stack
                        children: [
                          // Avatar centered in the stack
                          Center(
                            child: InkWell(
                              onTap: () => NextScreen.openBottomSheet(context,
                                  PublicProfile(user: userList[2], rank: 3)),
                              child: AvatarCircle(
                                  assetString: userList[2].avatarString,
                                  imageUrl: userList[2].imageUrl,
                                  size: 70,
                                  bgColor: ColorConfig.avatarBg2),
                            ),
                          ),
                          // Medal positioned at bottom of avatar, but overlapping
                          Positioned(
                            bottom: -20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Image.asset(
                                'assets/icons/medal-3.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      userList[2].name!.split(" ").firstOrNull!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${userList[2].points} Pt",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  // Container _topList(BuildContext context, List<UserModel> userList) {
  //   // Podium block height values - these should match what's in the Podium widget
  //   final double podiumHeight = 200;
  //   final double firstPodiumHeight = podiumHeight * 0.75;
  //   final double secondPodiumHeight = podiumHeight * 0.55;
  //   final double thirdPodiumHeight = podiumHeight * 0.45;
  //
  //   // Calculate vertical offsets for each position to match their respective podium heights
  //   final double firstOffset = 30; // Base offset for 1st place
  //   final double secondOffset = firstOffset + (firstPodiumHeight - secondPodiumHeight);
  //   final double thirdOffset = firstOffset + (firstPodiumHeight - thirdPodiumHeight);
  //
  //   return Container(
  //     alignment: Alignment.topCenter,
  //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
  //     height: _topHeaderHeight,
  //     decoration: BoxDecoration(
  //         color: Theme.of(context).primaryColor,
  //         borderRadius: const BorderRadius.only(
  //             bottomLeft: Radius.circular(30),
  //             bottomRight: Radius.circular(30)
  //         )
  //     ),
  //     child: Stack(
  //       fit: StackFit.expand,
  //       alignment: Alignment.bottomCenter,
  //       children: [
  //         // Position rankings at top
  //         // Positioned(
  //         //   top: 10,
  //         //   left: 0,
  //         //   right: 0,
  //         //   child: Row(
  //         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         //     children: [
  //         //       // 2nd place label
  //         //       if (userList.length >= 2)
  //         //         Text(
  //         //           "2nd",
  //         //           style: TextStyle(
  //         //             color: Colors.white,
  //         //             fontSize: 32,
  //         //             fontWeight: FontWeight.bold,
  //         //           ),
  //         //         ),
  //         //
  //         //       // 1st place label
  //         //       Text(
  //         //         "1st",
  //         //         style: TextStyle(
  //         //           color: Colors.white,
  //         //           fontSize: 36,
  //         //           fontWeight: FontWeight.bold,
  //         //         ),
  //         //       ),
  //         //
  //         //       // 3rd place label
  //         //       if (userList.length >= 3)
  //         //         Text(
  //         //           "3rd",
  //         //           style: TextStyle(
  //         //             color: Colors.white,
  //         //             fontSize: 32,
  //         //             fontWeight: FontWeight.bold,
  //         //           ),
  //         //         ),
  //         //     ],
  //         //   ),
  //         // ),
  //
  //         // Podium layer
  //         Positioned(
  //           bottom: 0,
  //           left: 0,
  //           right: 0,
  //           height: podiumHeight,
  //           child: Podium(
  //             width: MediaQuery.of(context).size.width - 20,
  //             height: podiumHeight,
  //             showNumbers: true,
  //             backgroundColor: Colors.transparent,
  //           ),
  //         ),
  //
  //         // 2nd place user
  //         if (userList.length >= 2)
  //           Positioned(
  //             bottom: secondPodiumHeight + secondOffset,
  //             left: 0,
  //             width: MediaQuery.of(context).size.width / 3,
  //             child: DelayedDisplay(
  //               delay: const Duration(milliseconds: 400),
  //               child: Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () => NextScreen.openBottomSheet(context,
  //                         PublicProfile(user: userList[1], rank: 2)),
  //                     child: AvatarCircle(
  //                         assetString: userList[1].avatarString,
  //                         imageUrl: userList[1].imageUrl,
  //                         size: 70,
  //                         bgColor: ColorConfig.avatarBg2),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Text(
  //                     userList[1].name!.split(" ").firstOrNull ?? '',
  //                     textAlign: TextAlign.center,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                         color: Colors.white, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: Text(
  //                       "${userList[1].points} Pt",
  //                       style: TextStyle(
  //                         color: Colors.indigo,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //         // 1st place user
  //         Positioned(
  //           bottom: firstPodiumHeight + firstOffset,
  //           left: MediaQuery.of(context).size.width / 3,
  //           width: MediaQuery.of(context).size.width / 3,
  //           child: DelayedDisplay(
  //             delay: const Duration(milliseconds: 200),
  //             child: Column(
  //               children: [
  //                 InkWell(
  //                   onTap: () => NextScreen.openBottomSheet(
  //                       context, PublicProfile(user: userList[0], rank: 1)),
  //                   child: AvatarCircle(
  //                       assetString: userList[0].avatarString,
  //                       imageUrl: userList[0].imageUrl,
  //                       size: 90,
  //                       bgColor: ColorConfig.avatarBg2),
  //                 ),
  //                 const SizedBox(height: 5),
  //                 Text(
  //                   userList[0].name!.split(" ").firstOrNull!,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                       color: Colors.white, fontWeight: FontWeight.w600),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Text(
  //                     "${userList[0].points} Pt",
  //                     style: TextStyle(
  //                       color: Colors.indigo,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         // 3rd place user
  //         if (userList.length >= 3)
  //           Positioned(
  //             bottom: thirdPodiumHeight + thirdOffset,
  //             right: 0,
  //             width: MediaQuery.of(context).size.width / 3,
  //             child: DelayedDisplay(
  //               delay: const Duration(milliseconds: 600),
  //               child: Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () => NextScreen.openBottomSheet(context,
  //                         PublicProfile(user: userList[2], rank: 3)),
  //                     child: AvatarCircle(
  //                         assetString: userList[2].avatarString,
  //                         imageUrl: userList[2].imageUrl,
  //                         size: 70,
  //                         bgColor: ColorConfig.avatarBg2),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Text(
  //                     userList[2].name!.split(" ").firstOrNull!,
  //                     textAlign: TextAlign.center,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
  //                         color: Colors.white, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: Text(
  //                       "${userList[2].points} Pt",
  //                       style: TextStyle(
  //                         color: Colors.indigo,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  AnimatedTextKit _animatedText() {
    return AnimatedTextKit(
      isRepeatingAnimation: true,
      repeatForever: true,
      animatedTexts: [
        ColorizeAnimatedText('first'.tr(),
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
            speed: const Duration(milliseconds: 800),
            colors: [
              Colors.white,
              Colors.green,
              Colors.yellow,
              Colors.pink,
            ]),
      ],
    );
  }
}