import 'package:airsense/constant/colors.dart';
import 'package:flutter/material.dart';


class DeviceUpdateInformation extends StatelessWidget {
  const DeviceUpdateInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(
            'Ultima actualización',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.grey500,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '14:30',
            style: TextStyle(
              fontSize: 60,
              color: AppColor.grey400,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '27 de agosto del 2023',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.grey200,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}