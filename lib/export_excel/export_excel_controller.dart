import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:packageku_refactor/export_excel/export_excel_view.dart';
import 'package:path_provider/path_provider.dart';

class ExportExcelController extends State<ExportExcelView> {
  static late ExportExcelController instance;
  late ExportExcelView view;

  final List<Map<String, dynamic>> jsonData = [
    {
      "id": 1,
      "name": "Andi",
      "address": {"city": "Jakarta", "zip": "10110"},
      "skills": ["Flutter", "Dart"],
    },
    {
      "id": 2,
      "name": "Budi",
      "address": {"city": "Bandung", "zip": "40123"},
      "skills": ["Design", "UI/UX"],
    },
    {
      "id": 3,
      "name": "Cici",
      "address": {"city": "Surabaya", "zip": "60111"},
      "skills": ["Backend", "Python"],
    },
    {
      "id": 4,
      "name": "Jono",
      "address": {"city": "Purwodadi", "zip": "58161"},
      "skills": ["Web3", "Flutter"],
    },
  ];

  bool isExporting = false;
  String? exportedFilePath;

  CellValue? _toCellValue(dynamic v) {
    if (v == null) return null;
    if (v is int) return IntCellValue(v);
    if (v is double) return DoubleCellValue(v);
    if (v is bool) return BoolCellValue(v);
    if (v is String) {
      final num? parsedNum = num.tryParse(v);
      if (parsedNum != null) {
        if (parsedNum is int) return IntCellValue(parsedNum);
        return DoubleCellValue(parsedNum.toDouble());
      }
    }
    return TextCellValue(v.toString());
  }

  Future<String?> _pickFolderPath() async {
    if (Platform.isAndroid) {
      // Android: bisa pilih folder
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      return selectedDirectory;
    } else if (Platform.isIOS) {
      // iOS tidak bisa pilih folder langsung, jadi nanti simpan via FileSaver
      return null;
    } else {
      return null;
    }
  }

  Future<void> exportJsonToExcel() async {
    try {
      setState(() {
        isExporting = true;
        exportedFilePath = null;
      });

      final excel = Excel.createExcel();
      const String sheetName = "Sheet1";
      final Sheet sheet = excel[sheetName];

      // Ambil semua key unik dari data
      final allKeys = <String>{};
      for (var item in jsonData) {
        allKeys.addAll(flattenJson(item).keys);
      }
      final headers = allKeys.toList()..sort();

      sheet.appendRow(headers.map((h) => TextCellValue(h)).toList());

      for (final item in jsonData) {
        final flatItem = flattenJson(item);
        final row = headers.map((key) {
          final val = flatItem[key];
          if (val is List) return TextCellValue(val.join(', '));
          if (val is Map) return TextCellValue(jsonEncode(val));
          return _toCellValue(val);
        }).toList();
        sheet.appendRow(row);
      }

      final fileBytes = excel.encode();
      if (fileBytes == null) throw Exception("Gagal encode Excel");

      final fileName =
          "data_export_${DateTime.now().millisecondsSinceEpoch}.xlsx";

      String? savePath;

      if (Platform.isAndroid) {
        // === Android: pilih folder dulu ===
        final folderPath = await _pickFolderPath();
        if (folderPath == null) {
          throw Exception("Penyimpanan dibatalkan user");
        }
        savePath = "$folderPath/$fileName";
        File(savePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes, flush: true);
      } else if (Platform.isIOS) {
        // === iOS: gunakan FileSaver (dialog Save As bawaan sistem) ===
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: Uint8List.fromList(
            fileBytes,
          ), // 🔧 konversi List<int> ke Uint8List
          mimeType: MimeType.microsoftExcel,
        );
        savePath = fileName;
      } else {
        final dir = await getApplicationDocumentsDirectory();
        savePath = "${dir.path}/$fileName";
        File(savePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes, flush: true);
      }

      setState(() {
        isExporting = false;
        exportedFilePath = savePath;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ File disimpan di: $savePath")));
    } catch (e) {
      setState(() => isExporting = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Gagal export: $e")));
    }
  }

  Map<String, dynamic> flattenJson(
    Map<String, dynamic> json, [
    String prefix = '',
  ]) {
    final Map<String, dynamic> result = {};
    json.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : "$prefix.$key";
      if (value is Map) {
        result.addAll(flattenJson(Map<String, dynamic>.from(value), newKey));
      } else if (value is List) {
        result[newKey] = value.join(", ");
      } else {
        result[newKey] = value;
      }
    });
    return result;
  }

  Future<void> openExportedFile() async {
    if (exportedFilePath == null) return;
    final result = await OpenFilex.open(exportedFilePath!);
    if (result.type != ResultType.done) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Gagal membuka file: ${result.message}")),
      );
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
