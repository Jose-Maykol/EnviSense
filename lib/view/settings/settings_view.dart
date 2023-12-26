import 'package:airsense/constant/colors.dart';
import 'package:airsense/widgets/headers/user_header.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  bool _switchNotification = false;
  bool _switchNotificationContacts = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          const UserHeader(),
          const SizedBox(height: 20),
          const Text(
            'Configuraciones',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.blue500,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.grey300,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Switch(
                value: _switchNotification,
                onChanged: (value) {
                  setState(() {
                    _switchNotification = value;
                  });
                },
                activeTrackColor: AppColor.blue100,
                activeColor: AppColor.blue500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notificaciones a mis contactos',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.grey300,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Switch(
                value: _switchNotificationContacts,
                onChanged: (value) {
                  setState(() {
                    _switchNotificationContacts = value;
                  });
                },
                activeTrackColor: AppColor.blue100,
                activeColor: AppColor.blue500,
              ),
            ],
          ),
          // const SettingsList(),
        ],
      ),
    );
  }
}