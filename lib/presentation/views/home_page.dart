import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/presentation/widgets/note_list.dart';

import '../bloc/note_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => injector()..add(NoteGetRequested()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("NoteCraft"),
          leading: const Icon(Icons.menu),
        ),
        floatingActionButton:
            const FloatingActionButton(onPressed: null, child: Text("Add")),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadSuccess) {
              return NoteList(notes: state.notes);
            }
            return const Text("no");
          },
        ));
  }
}
