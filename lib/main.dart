import 'package:airsense/constant/colors.dart';
import 'package:airsense/firebase_options.dart';
import 'package:airsense/services/firebase_api.dart';
import 'package:airsense/view/login/login_view.dart';
import 'package:airsense/view/main/main_view.dart';
import 'package:airsense/view/register/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;
  Widget startScreen = user == null ? LoginView() : const MainView();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: 'app_opened');
  FirebaseApi().initNotifications();
  runApp(MyApp(startScreen: startScreen));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  const MyApp({Key? key, required this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
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
        home: startScreen,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/home':(context) => const MainView(),
          '/register':(context) => RegisterView(),
        },
      ),
    );
  }
}