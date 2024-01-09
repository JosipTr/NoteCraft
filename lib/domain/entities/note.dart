import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String description;
  final int date;
  const Note(
      {this.id,
      required this.title,
      required this.description,
      required this.date});

  @override
  List<Object?> get props => [id, title, description, date];
}
