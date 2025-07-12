import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_controller.dart';

class EditNamaPage extends StatelessWidget {
  const EditNamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfilController>();
    final namaController =
        TextEditingController(text: controller.userName.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Nama Lengkap",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1456EA)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final namaBaru = namaController.text.trim();
                if (namaBaru.isNotEmpty) {
                  controller.updateNamaLengkap(namaBaru);
                } else {
                  Get.snackbar("Error", "Nama tidak boleh kosong");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1456EA),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(
                  color: Colors.white, // biar teksnya putih
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
