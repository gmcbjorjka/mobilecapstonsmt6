import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/penimbangan_history_controller.dart';

class PenimbanganHistoryView extends GetView<PenimbanganHistoryController> {
  const PenimbanganHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Penimbangan Ikan'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Grafik Bobot Ikan / Hari (7 Hari Terakhir)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    // BarChart utama
                    BarChart(
                      BarChartData(
                        maxY: _getMaxY(controller.bobotPerHari) + 1,
                        barTouchData: BarTouchData(enabled: false),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 ||
                                    index >= controller.bobotPerHari.length) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.bobotPerHari[index]['tanggal'],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        barGroups:
                            controller.bobotPerHari.asMap().entries.map((e) {
                          final index = e.key;
                          final bobot = (e.value['bobot'] as num).toDouble();
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: bobot,
                                width: 18,
                                borderRadius: BorderRadius.circular(4),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4C8BF5),
                                    Color(0xFFB3D4FF)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 400),
                      swapAnimationCurve: Curves.easeInOut,
                    ),

                    // Teks total bobot (dibulatkan) di atas masing-masing bar
                    Positioned.fill(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: controller.bobotPerHari.map((data) {
                          final bobot = (data['bobot'] as num).toDouble();
                          return Column(
                            children: [
                              Text(
                                '${bobot.round()} kg',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1.5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Detail Histori",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: controller.historiData.length,
                itemBuilder: (context, index) {
                  final data = controller.historiData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        'Tanggal: ${data['tanggal'].toString().split("T").first}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bobot Ikan: ${data['bobot']} kg'),
                          Text('Jumlah Ikan: ${data['jumlah_ikan']} ekor'),
                          Text('Lokasi: ${data['lokasi']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Hitung nilai maksimum Y untuk tinggi bar chart
  double _getMaxY(List<Map<String, dynamic>> data) {
    double max = 1.0;
    for (var item in data) {
      final value = (item['bobot'] as num).toDouble();
      if (value > max) max = value;
    }
    return max;
  }
}
