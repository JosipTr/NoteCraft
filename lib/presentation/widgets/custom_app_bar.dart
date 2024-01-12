import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../cubit/search_cubit/search_cubit.dart';
import 'widgets.dart';

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
