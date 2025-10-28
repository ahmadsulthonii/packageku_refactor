import 'package:flutter/material.dart';
import 'package:packageku_refactor/share_preference/share_preference_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceController extends State<SharePreferenceView> {
  static late SharePreferenceController instance;
  late SharePreferenceView view;
  final TextEditingController nameController = TextEditingController();
  String? savedName;
  bool isDarkMode = false;

  @override
  void initState() {
    instance = this;
    super.initState();
    loadData();
  }

  @override
  void dispose() => super.dispose();

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('username');
      isDarkMode = prefs.getBool('darkmode') ?? false;
    });
  }

  /// 💾 Simpan data ke SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);
    await prefs.setBool('darkmode', isDarkMode);
    loadData(); // refresh UI
  }

  /// ❌ Hapus data dari SharedPreferences
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('darkmode');
    setState(() {
      savedName = null;
      isDarkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
