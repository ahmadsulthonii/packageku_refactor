import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:packageku_refactor/image_resize/image_resize_controller.dart';
import 'package:packageku_refactor/ukuran.dart';

class ImageResizeView extends StatefulWidget {
  const ImageResizeView({super.key});

  Widget build(context, ImageResizeController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Image Resize')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: controller.pickAndResizeImage,
                icon: const Icon(Icons.photo),
                label: const Text('Pilih & Resize Gambar'),
              ),
              const SizedBox(height: 20),
              if (controller.originalImage != null) ...[
                const Text('Gambar Asli'),

                Image.file(controller.originalImage!, height: 150),
                Text(
                  'Ukuran ${Ukuran.formatImageSizeMB(controller.originalImage!)}',
                ),
              ],
              const SizedBox(height: 20),
              if (controller.resizedImage != null) ...[
                const Text('Gambar Setelah Resize:'),
                Image.file(controller.resizedImage!, height: 150),
                Text(
                  'Ukuran ${Ukuran.formatImageSizeMB(controller.resizedImage!)}',
                ),
                const SizedBox(height: 10),
                Text(
                  'Gambar disimpan di:\n${controller.resizedImage!.path}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await OpenFilex.open(
                      controller.resizedImage!.path,
                    );
                    if (result.type != ResultType.done && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Gagal membuka file: ${result.message}',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Buka Lokasi File'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<ImageResizeView> createState() => ImageResizeController();
}
