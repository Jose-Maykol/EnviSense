import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:airsense/constant/colors.dart';

class BarChartLastWeek extends StatelessWidget {
  const BarChartLastWeek({super.key});

  final List<String> days = const [ 'L', 'M', 'M', 'J', 'V', 'S', 'D',];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColor.grey200,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              )
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    days[value.toInt() - 1],
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColor.grey200,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ),
            )
          ),
          gridData: const FlGridData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 8,
                  width: 25,
                  color: AppColor.blue200,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 10,
                  width: 25,
                  color: AppColor.blue200,
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 14,
                  width: 25,
                  color: AppColor.blue300,
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: 12,
                  width: 25,
                  color: AppColor.blue300,
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  toY: 16,
                  width: 25,
                  color: AppColor.blue400,
                ),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(
                  toY: 18,
                  width: 25,
                  color: AppColor.blue200,
                ),
              ],
            ),
            BarChartGroupData(
              x: 7,
              barRods: [
                BarChartRodData(
                  toY: 20,
                  width: 25,
                  color: AppColor.blue400,
                ),
              ],
            ),
          ],
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
        swapAnimationCurve: Curves.easeInOut,
      ),
    );
  }
}