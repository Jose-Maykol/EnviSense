import 'package:airsense/constant/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDevice extends StatelessWidget {

  final DatabaseReference _deviceRef;
  final String deviceId;
  final String deviceUnit;
  final Color color;

  RealtimeDevice({
    super.key,
    required this.deviceId,
    required this.deviceUnit,
    required this.color,
  }):
    _deviceRef = FirebaseDatabase.instance.ref().child('devices/$deviceId');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _deviceRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final deviceData = snapshot.data!.snapshot.value;
          final value = deviceData['value'];
          final category = deviceData['category'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.39,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Text(
                          category ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/air.png'),
                          fit: BoxFit.contain,
                          alignment: Alignment.topLeft,
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: value.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: deviceUnit,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}