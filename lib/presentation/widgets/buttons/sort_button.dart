import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/note_bloc.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
            context.read<SettingsCubit>().setSortType(SortFilter.titleAsc);

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
            context.read<SettingsCubit>().setSortType(SortFilter.titleDesc);

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
            context.read<SettingsCubit>().setSortType(SortFilter.dateAsc);

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
            context.read<SettingsCubit>().setSortType(SortFilter.dateDesc);

            context.read<NoteBloc>().add(NoteGetRequested(
                (context.read<NoteBloc>().state as NoteLoadSuccess)
                    .noteFilter));
          },
        ),
      ],
    );
  }
}
