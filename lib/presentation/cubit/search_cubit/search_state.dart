// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  final bool isSearched;
  const SearchState({this.isSearched = false});

  @override
  List<Object> get props => [isSearched];

  SearchState copyWith({
    bool? isSearched,
  }) {
    return SearchState(
      isSearched: isSearched ?? this.isSearched,
    );
  }
}
