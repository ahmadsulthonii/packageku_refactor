import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packageku_refactor/date_time/date_time_view.dart';

class DateTimeController extends State<DateTimeView> {
  static late DateTimeController instance;
  late DateTimeView view;

  DateTimeRange? selectedRange;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  // Pilih rentang tanggal
  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange:
          selectedRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Pilih Rentang Tanggal',
      confirmText: 'Selesai',
      cancelText: 'Batal',
    );

    if (picked != null && picked != selectedRange) {
      setState(() => selectedRange = picked);
    }
  }

  // Pilih waktu
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  // Format tanggal
  String formatDate(DateTime dateTime) =>
      DateFormat('y MMMM dd', 'id_ID').format(dateTime);

  String formatDateTime(DateTime dateTime) {
    final formattedDate = DateFormat('y MMMM dd', 'id_ID').format(dateTime);
    final formattedTime = DateFormat('HH:mm').format(dateTime);
    return '$formattedDate, $formattedTime WIB';
  }

  /// 🔹 Gabungkan rentang tanggal & waktu
  String? getCombinedDateTime() {
    if (selectedRange == null || selectedTime == null) return null;

    final start = DateTime(
      selectedRange!.start.year,
      selectedRange!.start.month,
      selectedRange!.start.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final end = DateTime(
      selectedRange!.end.year,
      selectedRange!.end.month,
      selectedRange!.end.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    return '🗓️ Dari: ${formatDateTime(start)}\nSampai: ${formatDateTime(end)}';
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
