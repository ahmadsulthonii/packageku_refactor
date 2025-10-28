import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_crop/image_crop_controller.dart';
import 'package:packageku_refactor/ukuran.dart';

class ImageCropView extends StatefulWidget {
  const ImageCropView({super.key});

  Widget build(context, ImageCropController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker + Crop + Save')),
      body: Center(
        child: controller.croppedFile != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    File(controller.croppedFile!.path),
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ukuran file: ${Ukuran.formatImageSizeMB(File(controller.croppedFile!.path))}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 5),
                  FutureBuilder<String>(
                    future: Ukuran.getImagePixelSize(
                      File(controller.croppedFile!.path),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Gagal membaca ukuran pixel');
                      } else if (snapshot.hasData) {
                        return Text(
                          'Ukuran pixel: ${snapshot.data}',
                          style: const TextStyle(fontSize: 16),
                        );
                      } else {
                        return const SizedBox.shrink();
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
  State<ImageCropView> createState() => ImageCropController();
}
