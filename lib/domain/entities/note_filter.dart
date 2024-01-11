import 'package:notecraft/presentation/bloc/note_bloc.dart';

extension NoteFilterX on NoteFilter {
  String get title {
    switch (this) {
      case NoteFilter.main:
        return "Notes";
      case NoteFilter.trash:
        return "Trash";
      case NoteFilter.favorite:
        return "Favorites";
    }
  }
}
