import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/settings_bloc.dart';

import '../configs/app_config.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Image.asset(
            Config.logo,
            width: 140,
          ),
          Text(
            'App version: ${context.read<SettingsBloc>().appVersion} : ${context.read<SettingsBloc>().appBuildNumber}',
          ),
        ],
      ),
    );
  }
}
