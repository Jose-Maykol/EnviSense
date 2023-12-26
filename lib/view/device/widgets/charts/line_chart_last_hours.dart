import 'package:airsense/constant/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartLastHours extends StatelessWidget {
  const LineChartLastHours({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.85,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(
            show: false,
          ),
          gridData: const FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColor.grey200,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              )
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              )
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
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColor.grey200,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              )
            )
          ),
          minY: 0,
          maxY: 4,
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(1, 0.5),
                const FlSpot(2, 1),
                const FlSpot(3, 3),
                const FlSpot(4, 2),
                const FlSpot(5, 2.2),
                const FlSpot(6, 1.8),
                const FlSpot(7, 3),
                const FlSpot(8, 2.5),
              ],
              isCurved: true,
              color: AppColor.blue300,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                color: AppColor.blue300.withOpacity(0.2)
              ),
            ),
          ]
        ),
      )
    );
  }
}