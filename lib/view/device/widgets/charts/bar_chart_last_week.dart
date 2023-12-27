import 'package:airsense/models/data.dart';
import 'package:airsense/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:airsense/constant/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarChartLastWeek extends ConsumerWidget {
  final Color color;

  const BarChartLastWeek({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dataLastWeekAsyncValue = ref.watch(dataLastWeekProvider);

    return dataLastWeekAsyncValue.when(
      data: (data) {
        Map<String, double> generateDaysAverages(List<Data> data) {
          final Map<String, double> daysAverages = {};
          final DateTime today = DateTime.now();
          const List<String> defaultDays = [ 'L', 'Ma', 'Mi', 'J', 'V', 'S', 'D'];

          for (int i = 6; i >= 0; i--) {
            final DateTime day = today.subtract(Duration(days: i));
            final String dayInitial = defaultDays[day.weekday - 1];

            final dataForDay = data.where((element) {
              final DateTime elementDate = element.timestamp;
              return elementDate.day == day.day && 
                      elementDate.month == day.month && 
                      elementDate.year == day.year;
            }).toList();

            final double dayAverage = dataForDay.isEmpty 
              ? 0 
              : dataForDay.map((data) => data.value).reduce((a, b) => a + b) / dataForDay.length;

            daysAverages[dayInitial] = dayAverage;
          }
          return daysAverages;
        }

        final Map<String, double> daysAverages = generateDaysAverages(data);
        List<double> values = daysAverages.values.toList();

        return SizedBox(
          height: 200,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              // mod 5
              maxY: (daysAverages.values.fold<double>(0, (max, value) => value > max ? value : max) / 5).ceil() * 5,
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
                    getTitlesWidget: (value, _) {
                      int index = value.toInt().round() - 1;
                      if (index >= 0 && index < daysAverages.keys.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            daysAverages.keys.toList()[index],
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColor.grey200,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                )
              ),
              gridData: const FlGridData(
                show: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: values.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key + 1,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: color,
                      width: 16,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            swapAnimationDuration: const Duration(milliseconds: 250),
            swapAnimationCurve: Curves.easeInOut,
          ),
        );
      },
      loading: () => SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(
            color: color,
          )
        )
      ),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}