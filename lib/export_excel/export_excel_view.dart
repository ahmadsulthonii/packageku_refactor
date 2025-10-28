import 'package:flutter/material.dart';
import 'package:packageku_refactor/export_excel/export_excel_controller.dart';

class ExportExcelView extends StatefulWidget {
  const ExportExcelView({super.key});

  Widget build(context, ExportExcelController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Export JSON to Excel"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Data JSON:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: controller.jsonData.length,
                itemBuilder: (context, index) {
                  final item = controller.jsonData[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(item["id"].toString())),
                      title: Text(item["name"]),
                      subtitle: Text(
                        "Kota: ${item["address"]["city"]}\nSkill: ${(item["skills"] as List).join(", ")}",
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: controller.isExporting
                  ? null
                  : controller.exportJsonToExcel,
              icon: const Icon(Icons.file_download),
              label: Text(
                controller.isExporting ? "Mengekspor..." : "Export ke Excel",
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            if (controller.exportedFilePath != null)
              ElevatedButton.icon(
                onPressed: controller.openExportedFile,
                icon: const Icon(Icons.folder_open),
                label: const Text("Buka File Excel"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  State<ExportExcelView> createState() => ExportExcelController();
}
