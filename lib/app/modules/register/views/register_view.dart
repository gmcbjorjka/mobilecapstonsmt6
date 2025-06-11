import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_capstone/app/modules/register/controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
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
                child: Align(
                  alignment: Alignment.center,
                  child:
                      Image.asset('assets/images/logologin.png', height: 250),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  color: const Color(0xFF103CE7),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text('Buat Akun Smartfishing',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text(
                          'Isi formulir di bawah untuk membuat akun Smartfishing.',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 30),
                      const Text("Nama Lengkap",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (val) =>
                            controller.nameController.value = val,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nama Lengkap anda',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Email",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: (val) =>
                            controller.emailController.value = val,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Email anda',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Kata Sandi",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Obx(() => TextField(
                            obscureText: !controller.isPasswordVisible.value,
                            onChanged: (val) =>
                                controller.passwordController.value = val,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Kata Sandi anda',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      const Text("Konfirmasi Kata Sandi",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Obx(() => TextField(
                            obscureText:
                                !controller.isConfirmPasswordVisible.value,
                            onChanged: (val) => controller
                                .confirmPasswordController.value = val,
                            decoration: InputDecoration(
                              hintText: 'Ulangi Kata Sandi anda',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                              ),
                            ),
                          )),
                      const SizedBox(height: 30),
                      Obx(() => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.register,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: const Color(0xFF103CE7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text('Daftar',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                            ),
                          )),
                      const SizedBox(height: 20),
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
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: controller.signInWithGoogle,
                          icon: Image.asset('assets/icons/google_icon.png',
                              height: 24, width: 24),
                          label: const Text('Sign in with Google'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sudah Punya Akun?"),
                          TextButton(
                            onPressed: () => Get.toNamed('/login'),
                            child: const Text("Masuk",
                                style: TextStyle(
                                    color: Color(0xFF103CE7),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Mengalami Kendala? Hubungi Kami'),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
