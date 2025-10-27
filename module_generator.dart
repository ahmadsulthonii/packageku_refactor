import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length < 2) {
    print('❌ Penggunaan: dart module_generator.dart create <nama_module>');
    exit(1);
  }
  var action = arguments[0];
  var moduleName = arguments[1];

  switch (action) {
    case "create":
      var viewFile = File("lib/$moduleName/${moduleName}_view.dart");
      var controllerFile = File(
        "lib/$moduleName/${moduleName}_controller.dart",
      );
      viewFile.createSync(recursive: true);
      controllerFile.createSync(recursive: true);
      // create view
      var viewContent = """
import 'package:flutter/material.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({super.key});

  Widget build(context, ExampleController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CgMvc"),
        actions: const [],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  @override
  State<ExampleView> createState() => ExampleController();
}

""";
      viewFile.writeAsStringSync(viewContent);

      // create controller
      var controllerContent = """
import 'package:flutter/material.dart';

class ExampleController extends State<ExampleView> {
  static late ExampleController instance;
  late ExampleView view;

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

""";
      controllerFile.writeAsStringSync(controllerContent);
      print("✅ Module '$moduleName' berhasil dibuat!");
      break;
    default:
      print("❌ Aksi tidak dikenali: $action");
  }
}

String _capitalize(String text) =>
    text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
