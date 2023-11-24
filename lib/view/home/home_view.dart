import 'package:airsense/constant/colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://wrmx00.epimg.net/radio/imagenes/2022/08/08/martha_debayle/1659975395_023297_1659975782_noticia_normal.jpg'
                      )
                    ),
                    SizedBox(width: 10),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Bienvenido ',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.grey200,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Jose Maykol',
                            style: TextStyle(
                              fontSize: 20,
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
                    Navigator.pushNamed(context, '/');
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
            ),
          ],
        ),
      ),
    );
  }
}