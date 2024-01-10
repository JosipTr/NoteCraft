import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';

import '../bloc/note_bloc.dart';
import '../widgets/widgets.dart';
import 'views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => injector()..add(const NoteGetRequested(NoteFilter.notes)),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoadSuccess) return Text(state.title);
              return const Text("Notes");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNotePage())),
          child: const Text("Add"),
        ),
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
