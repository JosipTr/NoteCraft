import 'package:notecraft/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({super.id, required super.title, required super.description});

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

    final id = data['id'] as int?;

    return NoteModel(id: id, title: title, description: description);
  }
}
