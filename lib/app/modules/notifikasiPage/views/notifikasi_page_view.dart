import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/notifikasi_model.dart';
import '../controllers/notifikasi_page_controller.dart';

class NotifikasiView extends StatelessWidget {
  final NotifikasiPageController controller =
      Get.put(NotifikasiPageController());

  NotifikasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final NotifikasiModel notif = controller.notifications[index];
              return Column(
                children: [
                  NotifikasiItem(
                    icon: notif.icon,
                    iconColor: notif.iconColor,
                    title: notif.title,
                    description: notif.description,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          )),
    );
  }
}

class NotifikasiItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const NotifikasiItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
            ],
          ),
        ),
      ],
    );
  }
}
