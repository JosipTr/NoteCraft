import 'dart:developer';

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
        drawer: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            print(state.isSearched);
            log("message");
            if (state.isSearched) {
              return const SizedBox();
            }
            log("message2");
            return const Menu();
          },
        ),
        appBar: CustomAppBar(),
        floatingActionButton: const AddNotePageButton(),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadSuccess) {
              if (state.notes.isEmpty) return const NoteListEmpty();
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

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.isSearched) {
          return AppBar(
            title: TextField(
              decoration: const InputDecoration(hintText: "Search..."),
              autofocus: true,
              onChanged: (text) {
                context.read<NoteBloc>().add(NoteSearched(text));
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SearchCubit>().searchToggled();
                    context.read<NoteBloc>().add(NoteGetRequested(
                        (context.read<NoteBloc>().state as NoteLoadSuccess)
                            .noteFilter));
                  },
                  icon: const Icon(Icons.close))
            ],
          );
        }
        return AppBar(
          title: const AppBarTitle(),
          actions: [
            IconButton(
              onPressed: () => context.read<SearchCubit>().searchToggled(),
              icon: const Icon(Icons.search),
            ),
            const SortButton(),
            const DeleteAllNotesButton(),
          ],
        );
      },
    );
  }
}
