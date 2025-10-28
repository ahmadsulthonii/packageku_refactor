import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:packageku_refactor/image_picker/image_picker_controller.dart';
import 'package:packageku_refactor/ukuran.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({super.key});

  Widget build(context, ImagePickerController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker & Save')),
      body: Center(
        child: controller.imageFile != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    controller.imageFile!,

                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),

                  /// Gunakan FutureBuilder untuk menampilkan ukuran pixel gambar
                  FutureBuilder<String>(
                    future: Ukuran.getImagePixelSize(controller.imageFile!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Gagal membaca ukuran pixel');
                      } else {
                        return Column(
                          children: [
                            Text('Ukuran pixel gambar: ${snapshot.data}'),
                            Text(
                              'Ukuran file: ${Ukuran.formatImageSizeMB(controller.imageFile!)}',
                            ),
                            Text(
                              controller.savedPath ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  if (controller.savedPath != null)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.folder_open),
                      label: const Text('Buka File'),
                      onPressed: () async {
                        final result = await OpenFilex.open(
                          controller.savedPath!,
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
                    ),
                ],
              )
            : const Text('Belum ada gambar yang dipilih'),
      ),
      floatingActionButton: Wrap(
        spacing: 10,
        children: [
          FloatingActionButton(
            heroTag: 'camera',
            tooltip: 'Kamera',
            child: const Icon(Icons.camera_alt),
            onPressed: () => controller.pickImage(ImageSource.camera),
          ),
          FloatingActionButton(
            heroTag: 'gallery',
            tooltip: 'Galeri',
            child: const Icon(Icons.photo),
            onPressed: () => controller.pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  @override
  State<ImagePickerView> createState() => ImagePickerController();
}
