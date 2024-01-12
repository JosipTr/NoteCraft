import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/presentation/cubit/settings_cubit/settings_cubit.dart';

import '../bloc/note_bloc.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
          create: (_) =>
              injector()..add(const NoteGetRequested(NoteFilter.main)),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => injector(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => injector(),
        ),
      ],
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
        appBar: const CustomAppBar(),
        floatingActionButton: const AddNotePageButton(),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadSuccess) {
              if (state.notes.isEmpty) {
                return NoteListEmpty(noteFilter: state.noteFilter);
              }
              return NoteList(
                notes: state.notes,
                noteFilter: state.noteFilter,
              );
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
