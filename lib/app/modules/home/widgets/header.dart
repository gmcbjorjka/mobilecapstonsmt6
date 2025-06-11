import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart'; // ganti sesuai struktur folder kamu

class Header extends GetView<HomeController> {
  final bool isAppBar;
  const Header({super.key, this.isAppBar = false});

  @override
  Widget build(BuildContext context) {
    final textColor = isAppBar ? Colors.black : Colors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                controller
                    .getGreeting(), // bisa kamu ganti pakai fungsi greeting
                style: TextStyle(color: textColor, fontSize: 16)),
            Obx(() => Text(
                  controller
                      .userName.value, // pastikan userName adalah RxString
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.NOTIFIKASI_PAGE),
              icon: Icon(Icons.notifications_none, color: textColor),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.BANTUAN);
              },
              icon: Icon(Icons.help_outline, color: textColor),
            ),
          ],
        ),
      ],
    );
  }
}
