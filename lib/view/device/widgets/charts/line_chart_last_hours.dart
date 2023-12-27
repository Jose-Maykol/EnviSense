import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/data.dart';
import 'package:airsense/providers/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineChartLastHours extends ConsumerWidget {
  final Color color;

  const LineChartLastHours({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dataLastHoursAsyncValue = ref.watch(dataLastHoursProvider);

    return dataLastHoursAsyncValue.when(
      data: (data) {
        Map<int, double> generateHoursAverages(List<Data> data) {
          final Map<int, double> hoursAverages = {};
          final DateTime now = DateTime.now();

          for (int i = 7; i >= 0; i--) {
            final DateTime hour = now.subtract(Duration(hours: i));

            final dataForHour = data.where((element) {
              final DateTime elementDate = element.timestamp;
              return elementDate.hour == hour.hour && 
                      elementDate.day == hour.day && 
                      elementDate.month == hour.month && 
                      elementDate.year == hour.year;
            }).toList();

            final double hourAverage = dataForHour.isEmpty 
              ? 0 
              : dataForHour.map((data) => data.value).reduce((a, b) => a + b) / dataForHour.length;

            hoursAverages[hour.hour] = hourAverage;
          }
          return hoursAverages;
        }

        final Map<int, double> hoursAverages = generateHoursAverages(data);
        List<double> values = hoursAverages.values.toList();

        print('hoursAverages: $hoursAverages');

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
                    interval: 5,
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
                    getTitlesWidget: (value, _) {
                      int index = value.toInt().round() - 1;
                      if (index >= 0 && index < hoursAverages.keys.length) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            hoursAverages.keys.elementAt(index).toString(),
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
                    }
                  )
                )
              ),
              minY: 0,
              maxY: (values.fold<double>(0, (max, value) => value > max ? value : max) / 5).ceil() * 5,
              lineBarsData: [
                LineChartBarData(
                  spots: values.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value)).toList(),
                  isCurved: true,
                  color: color,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    color: color.withOpacity(0.2)
                  ),
                ),
              ]
            ),
          )
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(child: Text('Error')),
    );
  }
}