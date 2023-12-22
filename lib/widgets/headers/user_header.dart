import 'package:airsense/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
  });

  Future<List<String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? user = prefs.getString('user');
    String? photo = prefs.getString('photo');
    return [name, email, user, photo];
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('email');
    prefs.remove('name');
    prefs.remove('photo');
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<String?>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return const Text('Error al cargar los datos');
        }  
        else if (snapshot.hasData && snapshot.data != [ null, null, null, null ]) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: AppColor.blue500,
                      child: snapshot.data![3] != null
                          ? Image.network(
                              snapshot.data![3]!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                snapshot.data![1]![0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Bienvenido ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.grey200,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: snapshot.data![0] ?? snapshot.data![1],
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.blue500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),]
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  signOut().then((value) => Navigator.pushNamed(context, '/'));
                },
                iconSize: 25,
                padding: const EdgeInsets.all(0),
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.logout,
                  color: AppColor.grey300,
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}