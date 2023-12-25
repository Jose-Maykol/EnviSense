import 'package:airsense/widgets/headers/user_header.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: <Widget> [
          const UserHeader(),
          const SizedBox(height: 20),
          // const SettingsList(),
        ],
      ),
    );
  }
}