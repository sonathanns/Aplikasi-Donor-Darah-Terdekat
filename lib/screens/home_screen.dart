import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/blood_bank_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final bloodBankController = Get.find<BloodBankController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => bloodBankController.refreshBloodBanks(),
          color: const Color(0xFFE53935),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(authController),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(authController),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                    const SizedBox(height: 32),
                    _buildNearbySection(bloodBankController),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(authController),
    );
  }

  Widget _buildAppBar(AuthController authController) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF212121)),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF212121)),
            onPressed: () => Get.snackbar(
              'Info',
              'Fitur notifikasi segera hadir',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black87,
              borderRadius: 12,
              margin: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(AuthController authController) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.water_drop_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.water_drop, size: 16, color: Color(0xFFE53935)),
                    const SizedBox(width: 6),
                    Text(
                      authController.currentUser.value?.bloodType ?? '-',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE53935),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => Text(
            'Halo, ${authController.currentUser.value?.name ?? "Donor"}!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
          const SizedBox(height: 6),
          Text(
            'Siap berbagi kehidupan hari ini?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu Cepat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Cari PMI',
                  'Temukan lokasi terdekat',
                  Icons.search_rounded,
                  const Color(0xFF2196F3),
                      () => Get.toNamed('/blood-banks'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Riwayat',
                  'Lihat donasi Anda',
                  Icons.history_rounded,
                  const Color(0xFFFF9800),
                      () => Get.toNamed('/donation-history'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 24, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNearbySection(BloodBankController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PMI Terdekat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/blood-banks'),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    color: Color(0xFFE53935),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(color: Color(0xFFE53935)),
              ),
            );
          }

          if (controller.nearbyBloodBanks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.location_off_outlined, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'Tidak ada data PMI terdekat',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.nearbyBloodBanks.length,
            itemBuilder: (context, index) {
              final bloodBank = controller.nearbyBloodBanks[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Get.toNamed('/blood-bank-detail', arguments: bloodBank),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.local_hospital_rounded,
                              color: Color(0xFFE53935),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bloodBank.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF212121),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_rounded, size: 14, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      bloodBank.distance != null
                                          ? '${bloodBank.distance!.toStringAsFixed(1)} km'
                                          : 'Lokasi',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildDrawer(AuthController authController) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Obx(() => Text(
                      authController.currentUser.value?.name.substring(0, 1).toUpperCase() ?? 'D',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE53935),
                      ),
                    )),
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                Obx(() => Text(
                  authController.currentUser.value?.name ?? 'Donor',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(height: 4),
                // Email
                Obx(() => Text(
                  authController.currentUser.value?.email ?? '',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(height: 12),
                // Blood Type Badge
                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.water_drop_rounded, size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        authController.currentUser.value?.bloodType ?? '-',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildDrawerItem(
                  Icons.home_rounded,
                  'Beranda',
                      () => Get.back(),
                  isActive: true,
                ),
                const SizedBox(height: 4),
                _buildDrawerItem(
                  Icons.local_hospital_rounded,
                  'Daftar PMI',
                      () {
                    Get.back();
                    Get.toNamed('/blood-banks');
                  },
                ),
                const SizedBox(height: 4),
                _buildDrawerItem(
                  Icons.history_rounded,
                  'Riwayat Donor',
                      () {
                    Get.back();
                    Get.toNamed('/donation-history');
                  },
                ),
                const SizedBox(height: 4),
                _buildDrawerItem(
                  Icons.person_rounded,
                  'Profile',
                      () {
                    Get.back();
                    Get.toNamed('/profile');
                  },
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.grey[300]),
                ),
                const SizedBox(height: 8),
                _buildDrawerItem(
                  Icons.logout_rounded,
                  'Keluar',
                      () => _showLogoutDialog(authController),
                  isDestructive: true,
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      IconData icon,
      String title,
      VoidCallback onTap, {
        bool isDestructive = false,
        bool isActive = false,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE53935).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withOpacity(0.1)
                : isActive
                ? const Color(0xFFE53935).withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 22,
            color: isDestructive
                ? Colors.red
                : isActive
                ? const Color(0xFFE53935)
                : Colors.grey[700],
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive
                ? Colors.red
                : isActive
                ? const Color(0xFFE53935)
                : const Color(0xFF212121),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: !isDestructive
            ? Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: isActive ? const Color(0xFFE53935) : Colors.grey[400],
        )
            : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showLogoutDialog(AuthController authController) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Keluar Aplikasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Apakah Anda yakin ingin keluar dari aplikasi?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        authController.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Keluar'),
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
}