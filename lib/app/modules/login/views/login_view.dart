import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Column(
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF64E9FF), Color(0xFF103CE7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logologin.png',
                    height: 250,
                  ),
                ),
              ),
              Expanded(
                child: Container(color: const Color(0xFF103CE7)),
              ),
            ],
          ),

          // Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat Datang Di SmartFishing!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Login atau Register sekarang!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      const Text("Email"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Kata Sandi"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Kata Sandi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Row(
                                children: [
                                  Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: controller.toggleRememberMe,
                                    activeColor: const Color(0xFF103CE7),
                                  ),
                                  const Text('Ingatkan Saya'),
                                ],
                              )),
                          TextButton(
                            onPressed: controller.forgotPassword,
                            child: const Text('Lupa Kata Sandi?',
                                style: TextStyle(color: Color(0xFF103CE7))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Tombol MASUK
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF103CE7),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'MASUK',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

// Divider "Atau"
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Atau gunakan akun'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

// Sign in with Google
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: controller.loginWithGoogle,
                            icon: Image.asset(
                              'assets/icons/google_icon.png',
                              height: 24,
                              width: 24,
                            ),
                            label: const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(color: Colors.grey),
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Tidak punya akun?"),
                          TextButton(
                            onPressed: controller.goToRegister,
                            child: const Text("Buat Akun",
                                style: TextStyle(color: Color(0xFF103CE7))),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.BANTUAN);
                          },
                          child: const Text('Mengalami Kendala? Hubungi Kami',
                              style: TextStyle(color: Color(0xFF103CE7))),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Obx(() {
            return controller.isLoading.value
                ? Container(
                    color: Colors.black45,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
