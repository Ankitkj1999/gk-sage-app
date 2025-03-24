import 'package:flutter/material.dart';

class Config {
  //App Name
  static const String appName = "GK Sage";
  //Support Email
  static const String supportEmail = "appatankit@gmail.com";
  //iOS App Id (Only for iOS)
  static const String iOSAppId = '000000';

  //Links
  static const String privacyPolicyUrl =
      "https://www.mrb-lab.com/privacy-policy";
  static const String termsAndServiceUrl =
      "https://docs.flutter.dev/tos?_gl=1*8f0mmy*_ga*MTMzNDQ5NTQ4OC4xNzM4MDUxMjYw*_ga_04YGWK0175*MTc0MjMxODQwNy4yNS4wLjE3NDIzMTg0MTkuMC4wLjA.";
  static const String yourWebsiteUrl = "https://policies.google.com/privacy?hl=en";
  static const String fbPageUrl = 'https://www.facebook.com/FlutterCommunity/';
  static const String youtubeChannelUrl = 'https://www.youtube.com/@flutterdev';

  //App Icons & Logo
  static const String icon = 'assets/images/icon.png';
  static const String logo = 'assets/images/logo.png';
  static const String splashIcon = 'assets/images/adaptive-icon.png';
  // static const String splashIcon = 'assets/images/splash.png';

  //Introduction/On-Borading Screen Assets
  static final Map<int, List> intros = {
    //serical : background color, asset image
    1: [Colors.orange.shade400, "assets/images/intro_1.svg"],
    2: [Colors.red.shade300, "assets/images/intro_2.svg"],
    3: [Colors.pink.shade200, "assets/images/intro_3.svg"],
  };

  //Lottie animation files
  static const String emptyAnimation = 'assets/animations/empty.json';
  static const String notificationAnimation =
      'assets/animations/notification.json';
  static const String rewardAnimation = 'assets/animations/reward.json';
  static const String emptyBoxAnimation = 'assets/animations/empty_box.json';
  static const String quitAnimation = 'assets/animations/quit.json';
  static const String hiAnimation = 'assets/animations/hi.json';

  //Self chnalange mode thumnail cover image
  static const String selfChallengeCoverImage =
      'assets/images/self_ch_cover.jpg';

  //Default user avatar
  static const String defaultAvatarString =
      'assets/images/new_avatars/user001.png';

  //User Avatar List
  // static const List<String> userAvatars = [
  //   'assets/images/user_avatars/user1.png',
  //   'assets/images/user_avatars/user2.png',
  //   'assets/images/user_avatars/user3.png',
  //   'assets/images/user_avatars/user4.png',
  //   'assets/images/user_avatars/user5.png',
  //   'assets/images/user_avatars/user6.png',
  //   'assets/images/user_avatars/user7.png',
  //   'assets/images/user_avatars/user8.png',
  //   'assets/images/user_avatars/user9.png',
  //   'assets/images/user_avatars/user10.png',
  //   'assets/images/user_avatars/user11.png',
  //   'assets/images/user_avatars/user12.png',
  //   'assets/images/user_avatars/user13.png',
  //   'assets/images/user_avatars/user14.png',
  //   'assets/images/user_avatars/user15.png',
  //   'assets/images/user_avatars/user16.png',
  //   'assets/images/user_avatars/user17.png'
  // ];

  static const List<String> userAvatars = [
    'assets/images/new_avatars/user001.png',
    'assets/images/new_avatars/user002.png',
    'assets/images/new_avatars/user003.png',
    'assets/images/new_avatars/user004.png',
    'assets/images/new_avatars/user005.png',
    'assets/images/new_avatars/user006.png',
    'assets/images/new_avatars/user007.png',
    'assets/images/new_avatars/user008.png',
    'assets/images/new_avatars/user009.png',
    'assets/images/new_avatars/user010.png',
    'assets/images/new_avatars/user011.png',
    'assets/images/new_avatars/user012.png',
    'assets/images/new_avatars/user013.png',
    'assets/images/new_avatars/user014.png',
    'assets/images/new_avatars/user015.png',
    'assets/images/new_avatars/user016.png',
    'assets/images/new_avatars/user017.png',
    'assets/images/new_avatars/user018.png',
    'assets/images/new_avatars/user019.png',
    'assets/images/new_avatars/user020.png',
    'assets/images/new_avatars/user021.png',
    'assets/images/new_avatars/user022.png',
    'assets/images/new_avatars/user023.png',
    'assets/images/new_avatars/user024.png',
    'assets/images/new_avatars/user025.png',
    'assets/images/new_avatars/user026.png',
    'assets/images/new_avatars/user027.png',
    'assets/images/new_avatars/user028.png',
    'assets/images/new_avatars/user029.png',
    'assets/images/new_avatars/user030.png',
    'assets/images/new_avatars/user031.png',
    'assets/images/new_avatars/user032.png',
    'assets/images/new_avatars/user033.png',
    'assets/images/new_avatars/user034.png',
    'assets/images/new_avatars/user035.png',
    'assets/images/new_avatars/user036.png',
    'assets/images/new_avatars/user037.png',
    'assets/images/new_avatars/user038.png',
    'assets/images/new_avatars/user039.png',
    'assets/images/new_avatars/user040.png',
    'assets/images/new_avatars/user041.png',
    'assets/images/new_avatars/user042.png',
    'assets/images/new_avatars/user043.png',
    'assets/images/new_avatars/user044.png',
    'assets/images/new_avatars/user045.png',
    'assets/images/new_avatars/user046.png',
    'assets/images/new_avatars/user047.png',
    'assets/images/new_avatars/user048.png',
    'assets/images/new_avatars/user049.png',
    'assets/images/new_avatars/user050.png',
    'assets/images/new_avatars/user051.png',
    'assets/images/new_avatars/user052.png',
    'assets/images/new_avatars/user053.png',
    'assets/images/new_avatars/user054.png',
    'assets/images/new_avatars/user055.png',
    'assets/images/new_avatars/user056.png',
    'assets/images/new_avatars/user057.png',
    'assets/images/new_avatars/user058.png',
    'assets/images/new_avatars/user059.png',
    'assets/images/new_avatars/user060.png',
    'assets/images/new_avatars/user061.png',
    'assets/images/new_avatars/user062.png',
    'assets/images/new_avatars/user063.png',
    'assets/images/new_avatars/user064.png',
    'assets/images/new_avatars/user075.png',
    'assets/images/new_avatars/user076.png',
    'assets/images/new_avatars/user077.png',
    'assets/images/new_avatars/user078.png',
    'assets/images/new_avatars/user079.png',
    'assets/images/new_avatars/user080.png',
    'assets/images/new_avatars/user081.png',
    'assets/images/new_avatars/user082.png',
    'assets/images/new_avatars/user083.png',
    'assets/images/new_avatars/user084.png',
    'assets/images/new_avatars/user085.png',
    'assets/images/new_avatars/user086.png',
    'assets/images/new_avatars/user087.png',
    'assets/images/new_avatars/user088.png',
    'assets/images/new_avatars/user089.png',
    'assets/images/new_avatars/user090.png',
    'assets/images/new_avatars/user091.png',
    'assets/images/new_avatars/user092.png',
    'assets/images/new_avatars/user093.png',
    'assets/images/new_avatars/user094.png',
    'assets/images/new_avatars/user095.png',
    'assets/images/new_avatars/user096.png',
    'assets/images/new_avatars/user097.png',
    'assets/images/new_avatars/user098.png',
    'assets/images/new_avatars/user099.png',
    'assets/images/new_avatars/user100.png',
    'assets/images/new_avatars/user101.png',
    'assets/images/new_avatars/user102.png',
    'assets/images/new_avatars/user103.png',
    'assets/images/new_avatars/user104.png',
    'assets/images/new_avatars/user105.png',
    'assets/images/new_avatars/user106.png',
    'assets/images/new_avatars/user107.png',
    'assets/images/new_avatars/user108.png',
    'assets/images/new_avatars/user109.png',
    'assets/images/new_avatars/user110.png',
    'assets/images/new_avatars/user111.png',
    'assets/images/new_avatars/user112.png',
    'assets/images/new_avatars/user113.png',
    'assets/images/new_avatars/user114.png',
    'assets/images/new_avatars/user115.png',
    'assets/images/new_avatars/user116.png',
  ];

  //Audio Files
  static const String clickSound = 'assets/sounds/click.mp3';
  static const String optionsSound = 'assets/sounds/options.mp3';
  static const String congratsSound = 'assets/sounds/congrats.mp3';
}
