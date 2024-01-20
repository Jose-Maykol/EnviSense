import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/device.dart';
import 'package:airsense/view/device/widgets/device_update_information.dart';
import 'package:airsense/view/device/widgets/realtime_device.dart';
import 'package:airsense/view/device/widgets/charts/bar_chart_last_week.dart';
import 'package:airsense/view/device/widgets/charts/line_chart_last_hours.dart';
import 'package:flutter/material.dart';

class DeviceView extends StatelessWidget {

  final Device device;
  final Color color;

  const DeviceView({
    Key? key, 
    required this.device,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: Text(
          device.type,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  DeviceUpdateInformation(deviceId: device.id),
                  RealtimeDevice(
                    deviceId: device.id, 
                    deviceUnit: device.unit,
                    color: color
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Historial ultima semana',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.grey500,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              BarChartLastWeek(color: color),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Ultimas horas',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.grey500,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20),
              LineChartLastHours(color: color),
            ],
          ),
        ),
      ),
    );
  }
}