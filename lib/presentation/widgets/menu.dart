import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/presentation/bloc/note_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo-nobg.png',
                    height: 100,
                    width: 100,
                  ),
                  const Text('NoteCraft'),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Notes'),
            leading: const Icon(Icons.note),
            onTap: () {
              context
                  .read<NoteBloc>()
                  .add(const NoteGetRequested(NoteFilter.main));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Favorites'),
            leading: const Icon(Icons.star),
            onTap: () {
              context
                  .read<NoteBloc>()
                  .add(const NoteGetRequested(NoteFilter.favorite));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Trash'),
            leading: const Icon(Icons.delete),
            onTap: () {
              context
                  .read<NoteBloc>()
                  .add(const NoteGetRequested(NoteFilter.trash));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
