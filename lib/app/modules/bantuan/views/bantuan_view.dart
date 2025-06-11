import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BantuanView extends StatelessWidget {
  const BantuanView({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Tidak bisa membuka tautan');
    }
  }

  Widget _buildItem({
    IconData? iconData,
    String? assetPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.blue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Gunakan ikon dari asset jika tersedia, jika tidak pakai Icon bawaan
            assetPath != null
                ? Image.asset(assetPath, width: 28, height: 28)
                : Icon(iconData ?? Icons.help_outline,
                    size: 28, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF103CE7)),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Silakan Pilih Layanan Bantuan Kami',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // Facebook - pakai asset
          _buildItem(
            assetPath: 'assets/icons/facebook.png',
            title: 'Facebook',
            subtitle: 'Kunjungi halaman resmi Facebook kami.',
            onTap: () => _launchUrl('https://facebook.com'),
          ),

          // Instagram - pakai asset
          _buildItem(
            assetPath: 'assets/icons/instagram.png',
            title: 'Instagram',
            subtitle: 'Lihat informasi terbaru kami di Instagram.',
            onTap: () => _launchUrl('https://instagram.com'),
          ),

          // WhatsApp - pakai asset
          _buildItem(
            assetPath: 'assets/icons/whatsapp.png',
            title: 'Chat WhatsApp',
            subtitle: 'Hubungi kami langsung via WhatsApp.',
            onTap: () => _launchUrl('https://wa.me/6285972736905'),
          ),

          // Tambahan contoh dengan Icon bawaan
          // _buildItem(
          //   iconData: Icons.help_outline,
          //   title: 'FAQ',
          //   subtitle: 'Lihat pertanyaan yang sering diajukan.',
          //   onTap: () => _launchUrl('https://example.com/faq'),
          // ),
        ],
      ),
    );
  }
}
