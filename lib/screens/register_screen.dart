import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/validators.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final addressController = TextEditingController();
    final selectedBloodType = 'A+'.obs;
    final obscurePassword = true.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF212121)),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buat Akun Baru',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Daftar untuk mulai donor darah',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey[600], size: 22),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  validator: (value) => Validators.validateRequired(value, 'Nama'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600], size: 22),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Icon(Icons.phone_outlined, color: Colors.grey[600], size: 22),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<String>(
                  value: selectedBloodType.value,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF212121)),
                  decoration: InputDecoration(
                    labelText: 'Golongan Darah',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Icon(Icons.water_drop_outlined, color: Colors.grey[600], size: 22),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  items: AppConstants.bloodTypes.map((String type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      selectedBloodType.value = value;
                    }
                  },
                )),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 22),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  validator: (value) => Validators.validateRequired(value, 'Alamat'),
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword.value,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600], size: 22),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                      onPressed: () => obscurePassword.value = !obscurePassword.value,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                  validator: Validators.validatePassword,
                )),
                const SizedBox(height: 32),
                Obx(() => CustomButton(
                  text: 'Daftar',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authController.register({
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'password': passwordController.text,
                        'blood_type': selectedBloodType.value,
                        'address': addressController.text.trim(),
                      });
                    }
                  },
                  isLoading: authController.isLoading.value,
                  icon: Icons.check_rounded,
                )),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Color(0xFFE53935),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}