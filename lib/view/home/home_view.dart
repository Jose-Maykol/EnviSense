import 'package:airsense/constant/colors.dart';
import 'package:airsense/widgets/charts/bar_chart_last_week.dart';
import 'package:fl_chart/fl_chart.dart';
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 150,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text(
                        'Ultima actualización',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.grey500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '14:30',
                        style: TextStyle(
                          fontSize: 60,
                          color: AppColor.grey400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '27 de agosto del 2023',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.grey200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
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
                )
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Historial ultima semana',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.grey500,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            const BarChartLastWeek(),
          ],
        ),
      ),
    );
  }
}