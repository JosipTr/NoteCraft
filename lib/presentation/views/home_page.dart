import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/di/injector.dart';
import 'package:notecraft/domain/entities/note_filter.dart';
import 'package:notecraft/domain/entities/sort_filter.dart';
import 'package:notecraft/presentation/cubit/settings_cubit/settings_cubit.dart';

import '../bloc/note_bloc.dart';
import '../widgets/widgets.dart';
import 'views.dart';

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
        appBar: AppBar(
          title: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoadSuccess) return Text(state.noteFilter.title);
              return const Text("Notes");
            },
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.sort),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Title'),
                      Icon(Icons.arrow_upward),
                    ],
                  ),
                  onTap: () {
                    context
                        .read<SettingsCubit>()
                        .setSortType(SortFilter.titleAsc);

                    context.read<NoteBloc>().add(NoteGetRequested(
                        (context.read<NoteBloc>().state as NoteLoadSuccess)
                            .noteFilter));
                  },
                ),
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Title'),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                  onTap: () {
                    context
                        .read<SettingsCubit>()
                        .setSortType(SortFilter.titleDesc);

                    context.read<NoteBloc>().add(NoteGetRequested(
                        (context.read<NoteBloc>().state as NoteLoadSuccess)
                            .noteFilter));
                  },
                ),
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Date'),
                      Icon(Icons.arrow_upward),
                    ],
                  ),
                  onTap: () {
                    context
                        .read<SettingsCubit>()
                        .setSortType(SortFilter.dateAsc);

                    context.read<NoteBloc>().add(NoteGetRequested(
                        (context.read<NoteBloc>().state as NoteLoadSuccess)
                            .noteFilter));
                  },
                ),
                PopupMenuItem(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Date'),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                  onTap: () {
                    context
                        .read<SettingsCubit>()
                        .setSortType(SortFilter.dateDesc);

                    context.read<NoteBloc>().add(NoteGetRequested(
                        (context.read<NoteBloc>().state as NoteLoadSuccess)
                            .noteFilter));
                  },
                ),
              ],
            ),
            BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteLoadSuccess) {
                  if (state.noteFilter == NoteFilter.trash) {
                    return PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text("Empty Trash"),
                                onTap: () => context
                                    .read<NoteBloc>()
                                    .add(const NoteDeleteAllRequested()),
                              ),
                            ]);
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoadSuccess) {
              if (state.noteFilter == NoteFilter.trash ||
                  state.noteFilter == NoteFilter.favorite) {
                return const SizedBox();
              }
            }
            return FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddNotePage())),
              child: const Icon(Icons.note_add),
            );
          },
        ),
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
