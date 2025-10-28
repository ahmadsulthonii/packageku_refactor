import 'package:flutter/material.dart';
import 'package:packageku_refactor/share_preference/share_preference_controller.dart';

class SharePreferenceView extends StatefulWidget {
  const SharePreferenceView({super.key});

  Widget build(context, SharePreferenceController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Mode Gelap'),
              value: controller.isDarkMode,
              onChanged: (value) {
                controller.setState(() => controller.isDarkMode = value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: controller.saveData,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Data'),
            ),
            ElevatedButton.icon(
              onPressed: controller.clearData,
              icon: const Icon(Icons.delete),
              label: const Text('Hapus Data'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              controller.savedName != null
                  ? 'Nama tersimpan: ${controller.savedName}\nMode Gelap: ${controller.isDarkMode}'
                  : 'Belum ada data tersimpan',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<SharePreferenceView> createState() => SharePreferenceController();
}
