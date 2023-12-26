import 'package:airsense/constant/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDevice extends StatelessWidget {

  final DatabaseReference _deviceRef;
  final String deviceId;

  RealtimeDevice({
    super.key,
    required this.deviceId,
  }):
    _deviceRef = FirebaseDatabase.instance.ref().child(deviceId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _deviceRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final deviceData = snapshot.data!.snapshot.value;
          final value = deviceData['value'];
          // final category = deviceData['category'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.39,
              decoration: BoxDecoration(
                color: AppColor.blue500,
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
                        const Text(
                          'Calidad del aire',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.grey100,
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
                                const TextSpan(
                                  text: ' PMM',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColor.grey100,
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
      /* child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: AppColor.blue500,
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
                  const Text(
                    'Calidad del aire',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.grey100,
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '20',
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' PMM',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.grey100,
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
      ), */
    );
  }
}