import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtikelDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> artikel = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          artikel['judul'] ?? 'Detail Artikel',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1456EA),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              artikel['gambar'] ?? '',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image)),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel['judul'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1456EA),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Penulis: ${artikel['penulis'] ?? '-'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    artikel['isi'] ?? '',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
