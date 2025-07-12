import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_history_controller.dart';

class LoginHistoryView extends StatelessWidget {
  final controller = Get.put(LoginHistoryController());

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Body background putih
      appBar: AppBar(
        title: const Text('Riwayat Login',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.historyList.isEmpty) {
          return const Center(child: Text('Belum ada riwayat login'));
        }

        return Container(
          color: Colors.white, // ListView background putih
          child: ListView.builder(
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final item = controller.historyList[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3), // abu-abu transparan
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(Icons.login, color: Colors.blueAccent),
                  title: Text(item.email,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_formatDate(item.loginTime)),
                      Text('Device: ${item.device}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.network_wifi, color: Colors.blue),
                      Text(item.ipAddress,
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
