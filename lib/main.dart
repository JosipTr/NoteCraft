import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/presentation/views/home_page.dart';
import 'package:notecraft/utils/theme/note_theme.dart';

import 'presentation/bloc/note_bloc.dart';

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
      home: BlocProvider<NoteBloc>(
        create: (_) => injector(),
        child: const MainAppView(),
      ),
    );
  }
}

class MainAppView extends StatelessWidget {
  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial || state is NoteLoadInProgress) {
          context.read<NoteBloc>().add(const NoteGetRequested(NoteFilter.main));
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png"),
                const CircularProgressIndicator()
              ],
            ),
          );
        }
        return const HomePage();
      },
    );
  }
}
