import 'package:airsense/constant/colors.dart';
import 'package:airsense/firebase_options.dart';
import 'package:airsense/view/home/home_view.dart';
import 'package:airsense/view/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.blue400,
          background: AppColor.white,
          primary: AppColor.blue400,
          secondary: AppColor.blue500,
          tertiary: AppColor.grey500,
          primaryContainer: AppColor.blue400,
          secondaryContainer: AppColor.blue500,
        )
      ),
      home: LoginView(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeView(),
      },
    );
  }
}