import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/blood_bank_controller.dart';
import '../models/blood_bank.dart';

class BloodBankListScreen extends StatelessWidget {
  const BloodBankListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BloodBankController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Daftar PMI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF212121),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () => Get.snackbar(
                'Info',
                'Fitur filter segera hadir',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.white,
                colorText: Colors.black87,
                borderRadius: 12,
                margin: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE53935)),
          );
        }

        if (controller.bloodBanks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Tidak ada data PMI',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshBloodBanks(),
          color: const Color(0xFFE53935),
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.bloodBanks.length,
            itemBuilder: (context, index) {
              final bloodBank = controller.bloodBanks[index];
              return _buildBloodBankCard(bloodBank);
            },
          ),
        );
      }),
    );
  }

  Widget _buildBloodBankCard(BloodBank bloodBank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.local_hospital_rounded,
                        color: Colors.white,
                        size: 28,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          if (bloodBank.distance != null) ...[
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${bloodBank.distance!.toStringAsFixed(1)} km',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 18, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              bloodBank.address,
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 18, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              bloodBank.operatingHours,
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _makePhoneCall(bloodBank.phone),
                        icon: const Icon(Icons.phone_rounded, size: 18),
                        label: const Text('Telepon'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFE53935),
                          side: const BorderSide(color: Color(0xFFE53935)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Get.toNamed('/blood-bank-detail', arguments: bloodBank),
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: const Text('Detail'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE53935),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
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

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    // await launchUrl(launchUri);
  }
}