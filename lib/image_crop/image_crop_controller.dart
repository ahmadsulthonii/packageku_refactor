import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packageku_refactor/image_crop/image_crop_view.dart';
import 'package:path_provider/path_provider.dart';

class ImageCropController extends State<ImageCropView> {
  static late ImageCropController instance;
  late ImageCropView view;

  final ImagePicker picker = ImagePicker();
  CroppedFile? croppedFile;
  String? savedPath;

  // Ambil gambar dari kamera atau galeri
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    var cropped = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      // Setting cropper
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Potong Gambar',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.deepPurple,
          lockAspectRatio: false,
          initAspectRatio: CropAspectRatioPreset.original,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
          cropStyle: CropStyle.rectangle,
        ),
        IOSUiSettings(title: 'Potong Gambar', aspectRatioLockEnabled: false),
      ],
    );

    if (cropped != null) {
      setState(() {
        croppedFile = cropped;
      });
      await saveImage(File(croppedFile!.path));
    }
  }

  // Simpan hasil crop ke folder aplikasi
  Future<void> saveImage(File image) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await image.copy('${dir.path}/$name');

    if (!mounted) return;

    setState(() => savedPath = saved.path);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Gambar disimpan di: $savedPath')));
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
