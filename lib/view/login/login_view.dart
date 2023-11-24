
import 'package:airsense/constant/colors.dart';
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
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17, horizontal: 40)),
                    backgroundColor: MaterialStateProperty.all(AppColor.blue400),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return AppColor.blue500;
                        }
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed)) {
                          return AppColor.blue500;
                        }
                        return null; // Defer to the widget's default.
                        },
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 0)
                    ),
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
                    backgroundColor: MaterialStateProperty.all(AppColor.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return AppColor.grey100;
                        }
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed)) {
                          return AppColor.grey100;
                        }
                        return null;
                        },
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 0)
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: AppColor.grey400,
                        width: 1,
                      )
                    ),
                  ),
                  icon: Image.asset('assets/icons/google.png', width: 20, height: 20),
                  label: const Text(
                    'Ingresar con Google',
                    style: TextStyle(
                      color: AppColor.black,
                    ),
                  )
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: AppColor.grey400,
                  height: 1,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17, horizontal: 40)),
                    backgroundColor: MaterialStateProperty.all(AppColor.white),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return AppColor.grey100;
                        }
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed)) {
                          return AppColor.grey100;
                        }
                        return null;
                        },
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 0)
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: AppColor.grey200,
                        width: 1,
                      )
                    ),
                  ),
                  child: const Text(
                    'Registrarte',
                    style: TextStyle(
                      color: AppColor.grey200,
                    ),
                  ),
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