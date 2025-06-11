import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/ganti_katasandi/controllers/ganti_katasandi_controller.dart';

class GantiKatasandiView extends GetView<GantiKatasandiController> {
  const GantiKatasandiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ganti Kata Sandi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF103CE7)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Silakan masukkan kata sandi lama dan kata sandi baru Anda.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Text("Kata Sandi Lama"),
              const SizedBox(height: 8),
              TextField(
                controller: controller.oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi Lama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Kata Sandi Baru"),
              const SizedBox(height: 8),
              TextField(
                controller: controller.newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Ulangi Kata Sandi"),
              const SizedBox(height: 8),
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Ulangi Kata Sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF103CE7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
