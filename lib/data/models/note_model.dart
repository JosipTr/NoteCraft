import 'package:notecraft/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    super.id,
    required super.title,
    required super.description,
    required super.date,
    super.isSelected,
    super.isFavorite,
    super.isDeleted,
  });

  factory NoteModel.fromJson(Map<String, dynamic> data) {
    final title = data['title'];
    if (title is! String) {
      throw FormatException(
          'Invalid JSON: required "title" field of type String in $data');
    }
    final description = data['description'];
    if (description is! String) {
      throw FormatException(
          'Invalid JSON: required "description" field of type String in $data');
    }

    final date = data['date'];
    if (date is! int) {
      throw FormatException(
          'Invalid JSON: required "date" field of type String in $data');
    }

    final isFavorite = data['favorite'];
    if (isFavorite is! bool) {
      throw FormatException(
          'Invalid JSON: required "isFavorite" field of type bool in $data');
    }

    final isDeleted = data['deleted'];
    if (isDeleted is! bool) {
      throw FormatException(
          'Invalid JSON: required "isDeleted" field of type bool in $data');
    }

    final id = data['id'] as int?;

    return NoteModel(
        id: id,
        title: title,
        description: description,
        date: date,
        isFavorite: isFavorite,
        isSelected: false,
        isDeleted: isDeleted);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'favorite': isFavorite,
      'deleted': isDeleted,
      if (id != null) 'id': id
    };
  }

  factory NoteModel.fromNote(Note note) {
    return NoteModel(
      id: note.id,
      title: note.title,
      description: note.description,
      date: note.date,
      isFavorite: note.isFavorite,
      isSelected: note.isSelected,
      isDeleted: note.isDeleted,
    );
  }
}
