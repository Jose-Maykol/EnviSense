import 'package:airsense/constant/colors.dart';
import 'package:airsense/providers/device_provider.dart';
import 'package:airsense/view/device/widgets/device_card.dart';
import 'package:airsense/widgets/headers/user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final devicesAsyncValue = ref.watch(deviceProvider);

    return devicesAsyncValue.when(
      data: (devices) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const UserHeader(),
              const SizedBox(height: 20),
              const Text(
                'Tus dispositivos',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.blue500,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              if (devices.isEmpty)
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'No tienes dispositivos',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.grey300,
                      ),
                    )
                  ),
                )
              else
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.9,
                  ),
                  padding: const EdgeInsets.all(0),
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    return DeviceCard(device: devices[index]);
                  },
                )
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(child: Text('Error')),
    );
  }
}