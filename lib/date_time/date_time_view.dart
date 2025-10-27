import 'package:flutter/material.dart';
import 'package:packageku_refactor/date_time/date_time_controller.dart';

class DateTimeView extends StatefulWidget {
  const DateTimeView({super.key});

  Widget build(context, DateTimeController controller) {
    controller.view = this;
    final combinedDateTime = controller.getCombinedDateTime();

    return Scaffold(
      appBar: AppBar(title: const Text('Date Range & Time Picker')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.selectDateRange(context),
                icon: const Icon(Icons.date_range),
                label: const Text('Pilih Rentang Tanggal'),
              ),
              const SizedBox(height: 10),
              Text(
                controller.selectedRange == null
                    ? 'Belum memilih rentang tanggal'
                    : 'Dari: ${controller.formatDate(controller.selectedRange!.start)}\n'
                          'Sampai: ${controller.formatDate(controller.selectedRange!.end)}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => controller.selectTime(context),
                icon: const Icon(Icons.access_time),
                label: const Text('Pilih Waktu'),
              ),
              const SizedBox(height: 10),
              Text(
                controller.selectedTime == null
                    ? 'Belum memilih waktu'
                    : 'Waktu: ${controller.selectedTime!.format(context)}',
              ),
              const SizedBox(height: 30),
              if (combinedDateTime != null)
                Text(
                  combinedDateTime,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<DateTimeView> createState() => DateTimeController();
}
