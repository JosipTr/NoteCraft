import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/presentation/widgets/note_list.dart';

import '../bloc/note_bloc.dart';
import '../widgets/note_failure.dart';
import '../widgets/note_list_empty.dart';

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
        floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<NoteBloc>().add(NoteAdded()),
            child: const Text("Add")),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadSuccess) {
              if (state.notes.isEmpty) return const NoteListEmpty();
              return NoteList(notes: state.notes);
            }
            if (state is NoteLoadFailure) {
              return const NoteFailure();
            }
            if (state is NoteLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Text("Else");
          },
        ));
  }
}
