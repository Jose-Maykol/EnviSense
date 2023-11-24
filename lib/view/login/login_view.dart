
import 'package:airsense/constant/colors.dart';
import 'package:airsense/widgets/buttons/button.dart';
import 'package:airsense/widgets/buttons/button_icon.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.blue400,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/airsense.png',
                      width: 115,
                      height: 115
                    )
                  )
                ),
                const SizedBox(height: 20),
                const Text(
                  'AirSense',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColor.blue400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                    print('Ingresar');
                  },
                  backgroundColor: AppColor.blue400,
                  overlayColor: AppColor.blue500,
                  textColor: AppColor.white,
                  text: 'Ingresar',
                ),
                const SizedBox(height: 20),
                ButtonIcon(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/google.png', width: 20, height: 20),
                  backgroundColor: AppColor.white,
                  overlayColor: AppColor.grey100,
                  textColor: AppColor.grey500,
                  borderColor: AppColor.grey200,
                  text: 'Ingresar con Google',
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: AppColor.grey400,
                  height: 1,
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {},
                  backgroundColor: AppColor.white,
                  overlayColor: AppColor.grey100,
                  textColor: AppColor.grey400,
                  borderColor: AppColor.grey200, 
                  text: 'Registrarse',
                )
              ],
            )
          ),
          Positioned(
            top: -50,
            left: -25,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: AppColor.blue400,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}