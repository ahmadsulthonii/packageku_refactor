import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_picker/image_picker_view.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerController extends State<ImagePickerView> {
  static late ImagePickerController instance;
  late ImagePickerView view;
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? savedPath;

  // Fungsi untuk memilih gambar
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });

      await saveImage(File(pickedFile.path));
    }
  }

  // Fungsi untuk menyimpan gambar ke folder aplikasi
  Future<void> saveImage(File image) async {
    try {
      // Ambil direktori penyimpanan aplikasi
      final directory = await getApplicationDocumentsDirectory();

      // Buat nama file baru berdasarkan waktu
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Path lengkap file tujuan
      final savedImage = await image.copy('${directory.path}/$fileName');

      if (!mounted) return;

      setState(() {
        savedPath = savedImage.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar berhasil disimpan di: $savedPath')),
      );
    } catch (e) {
      debugPrint("Gagal menyimpan gambar: $e");
    }
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
