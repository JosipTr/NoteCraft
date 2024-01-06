import 'package:flutter/material.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/presentation/views/home_page.dart';
import 'package:notecraft/utils/theme/note_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterNoteTheme.light,
      darkTheme: FlutterNoteTheme.dark,
      home: const HomePage(),
    );
  }
}
