import '../../domain/entities/entities.dart';

void sortNotes(List<Note> notes, String sortType) {
  if (sortType == 'titleAsc') {
    notes.sort((a, b) => a.title.compareTo(b.title));
  } else if (sortType == 'titleDesc') {
    notes.sort((a, b) => b.title.compareTo(a.title));
  } else if (sortType == 'dateAsc') {
    notes.sort((a, b) => a.date.compareTo(b.date));
  } else if (sortType == 'dateDesc') {
    notes.sort((a, b) => b.date.compareTo(a.date));
  } else {
    notes.sort((a, b) => a.title.compareTo(b.title));
  }
}
