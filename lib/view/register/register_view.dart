import 'package:airsense/constant/colors.dart';
import 'package:airsense/widgets/buttons/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser(BuildContext context) {
    final email = emailController.text;
    final password = passwordController.text;
    registerWithEmailPassword(email, password).then(
      (success) => {
        emailController.clear(),
        passwordController.clear(),
        if (success) Navigator.pushNamed(context, '/home')
        else ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al registrarse'),
          ),
        ),
      },
    );
  }

  Future<bool> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print(user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', user?.uid.toString() ?? '');
      prefs.setString('email', user?.email.toString() ?? '');
      prefs.setString('name', user?.displayName.toString() ?? '');
      prefs.setString('photo', user?.photoURL.toString() ?? '');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
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
                    signInUser(context);
                  },
                  backgroundColor: AppColor.blue400,
                  overlayColor: AppColor.blue500,
                  textColor: AppColor.white,
                  text: 'Registrarse',
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  backgroundColor: AppColor.white,
                  overlayColor: AppColor.grey100,
                  textColor: AppColor.grey400,
                  borderColor: AppColor.grey200, 
                  text: 'Volver',
                ),
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
                  'Register',
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

