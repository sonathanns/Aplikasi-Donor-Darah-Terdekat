import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/blood_bank.dart';
import '../controllers/auth_controller.dart';
import '../controllers/donation_controller.dart';
import '../widgets/custom_button.dart';

/// Screen untuk menampilkan detail informasi PMI (Palang Merah Indonesia)
/// Menampilkan informasi lengkap, kontak, dan tombol untuk mendaftar donor
class BloodBankDetailScreen extends StatelessWidget {
  const BloodBankDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil data blood bank dari arguments navigasi
    final bloodBank = Get.arguments as BloodBank;
    // Mendapatkan instance auth controller
    final authController = Get.find<AuthController>();
    // State untuk loading indicator
    final isLoading = false.obs;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App bar dengan header gradient
          _buildAppBar(bloodBank),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Section informasi PMI
                _buildInfoSection(bloodBank),
                const SizedBox(height: 20),
                // Section kontak dan aksi
                _buildContactSection(bloodBank),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      // Bottom bar dengan tombol daftar donor
      bottomNavigationBar: _buildBottomBar(bloodBank, authController, isLoading),
    );
  }

  /// Membangun app bar dengan gradient background dan informasi dasar
  Widget _buildAppBar(BloodBank bloodBank) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFFE53935),
      // Custom back button dengan background putih
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF212121)),
          onPressed: () => Get.back(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Pattern background dengan opacity rendah
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    'assets/pattern.png',
                    repeat: ImageRepeat.repeat,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(),
                  ),
                ),
              ),
              // Konten utama: icon, nama, dan jarak
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon hospital dengan background semi-transparent
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.local_hospital_rounded,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nama blood bank
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        bloodBank.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Badge jarak jika data tersedia
                    if (bloodBank.distance != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on_rounded, size: 16, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              '${bloodBank.distance!.toStringAsFixed(1)} km dari Anda',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Membangun section informasi lengkap PMI
  Widget _buildInfoSection(BloodBank bloodBank) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading section
          const Text(
            'Informasi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 16),
          // Card alamat
          _buildInfoCard(
            Icons.location_on_rounded,
            'Alamat',
            bloodBank.address,
          ),
          const SizedBox(height: 12),
          // Card jam operasional
          _buildInfoCard(
            Icons.access_time_rounded,
            'Jam Operasional',
            bloodBank.operatingHours,
          ),
          const SizedBox(height: 12),
          // Card nomor telepon
          _buildInfoCard(
            Icons.phone_rounded,
            'Telepon',
            bloodBank.phone,
          ),
        ],
      ),
    );
  }

  /// Membangun card informasi individual dengan icon, label, dan value
  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container dengan background merah muda
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE53935).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFE53935), size: 22),
          ),
          const SizedBox(width: 16),
          // Label dan value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label dengan warna abu-abu
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                // Value dengan font tebal
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun section kontak dengan tombol telepon dan petunjuk arah
  Widget _buildContactSection(BloodBank bloodBank) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading section
          const Text(
            'Kontak',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Tombol telepon
              Expanded(
                child: _buildActionButton(
                  'Telepon',
                  Icons.phone_rounded,
                  const Color(0xFF2196F3),
                      () async {
                    // Membuka dialer telepon
                    final Uri launchUri = Uri(scheme: 'tel', path: bloodBank.phone);
                    await launchUrl(launchUri);
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Tombol petunjuk arah
              Expanded(
                child: _buildActionButton(
                  'Petunjuk',
                  Icons.map_rounded,
                  const Color(0xFF4CAF50),
                      () async {
                    // Membuka Google Maps dengan koordinat PMI
                    final url = 'https://www.google.com/maps/search/?api=1&query=${bloodBank.latitude},${bloodBank.longitude}';
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Membangun tombol aksi dengan icon dan label
  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun bottom bar dengan tombol daftar donor
  Widget _buildBottomBar(BloodBank bloodBank, AuthController authController, RxBool isLoading) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() => CustomButton(
          text: 'Daftar Donor',
          onPressed: () => _createDonationRequest(bloodBank, authController),
          isLoading: isLoading.value,
          icon: Icons.volunteer_activism_rounded,
        )),
      ),
    );
  }

  /// Menampilkan dialog konfirmasi untuk membuat permintaan donor
  void _createDonationRequest(BloodBank bloodBank, AuthController authController) {
    // Mengambil data user yang sedang login
    final user = authController.currentUser.value;
    if (user == null) return;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon volunteer dengan background merah muda
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: Color(0xFFE53935),
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              // Judul dialog
              const Text(
                'Konfirmasi Donor',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Container informasi donor
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Info lokasi PMI
                    _buildDialogInfo('Lokasi', bloodBank.name),
                    const Divider(height: 20),
                    // Info golongan darah user
                    _buildDialogInfo('Golongan Darah', user.bloodType),
                    const Divider(height: 20),
                    // Info jumlah darah yang akan didonor
                    _buildDialogInfo('Jumlah', '350 ml'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Tombol batal
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tombol konfirmasi
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        // Membuat donation request ke controller
                        final donationController = Get.put(DonationController());
                        donationController.createDonation({
                          'user_id': user.id,
                          'blood_bank_id': bloodBank.id,
                          'donation_date': DateTime.now().toIso8601String(),
                          'blood_type': user.bloodType,
                          'quantity': 350,
                          'status': 'pending',
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Konfirmasi'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Membangun baris informasi untuk dialog dengan label dan value
  Widget _buildDialogInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label dengan warna abu-abu
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        // Value dengan font tebal
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}