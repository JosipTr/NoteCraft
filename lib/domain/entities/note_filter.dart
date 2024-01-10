import 'package:notecraft/presentation/bloc/note_bloc.dart';

extension NoteFilterX on NoteFilter {
  String get title {
    switch (this) {
      case NoteFilter.notes:
        return "Notes";
      case NoteFilter.deleted:
        return "Trash";
      case NoteFilter.favorite:
        return "Favorites";
    }
  }
}
