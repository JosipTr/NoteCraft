// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String description;
  final int date;
  final bool isSelected;
  final bool isFavorite;
  final bool isDeleted;
  const Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isSelected = false,
    this.isFavorite = false,
    this.isDeleted = false,
  });

  @override
  List<Object?> get props =>
      [id, title, description, date, isSelected, isFavorite, isDeleted];

  Note copyWith({
    int? id,
    String? title,
    String? description,
    int? date,
    bool? isSelected,
    bool? isFavorite,
    bool? isDeleted,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
