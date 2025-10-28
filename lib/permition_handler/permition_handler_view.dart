import 'package:flutter/material.dart';
import 'package:packageku_refactor/permition_handler/permition_handler_controller.dart';

class PermitionHandlerView extends StatefulWidget {
  const PermitionHandlerView({super.key});

  Widget build(context, PermitionHandlerController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Permission Handler')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: controller.requestCameraPermission,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Izin Kamera'),
              ),
              ElevatedButton.icon(
                onPressed: controller.requestLocationPermission,
                icon: const Icon(Icons.location_on),
                label: const Text('Izin Lokasi'),
              ),
              ElevatedButton.icon(
                onPressed: controller.requestStoragePermission,
                icon: const Icon(Icons.folder),
                label: const Text('Izin Storage'),
              ),
              ElevatedButton.icon(
                onPressed: controller.requestNotificationPermission,
                icon: const Icon(Icons.notifications),
                label: const Text('Izin Notifikasi'),
              ),
              ElevatedButton.icon(
                onPressed: controller.requestAllPermissions,
                icon: const Icon(Icons.security),
                label: const Text('Minta Semua Izin'),
              ),
              ElevatedButton.icon(
                onPressed: controller.openAppSettings,
                icon: const Icon(Icons.settings),
                label: const Text('Buka Pengaturan Aplikasi'),
              ),
              const SizedBox(height: 20),
              Text(
                'Status:\n${controller.status}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<PermitionHandlerView> createState() => PermitionHandlerController();
}
