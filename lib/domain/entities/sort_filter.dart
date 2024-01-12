enum SortFilter { titleAsc, titleDesc, dateAsc, dateDesc }

extension SortFilterX on SortFilter {
  String get sortType {
    switch (this) {
      case SortFilter.titleAsc:
        return "titleAsc";
      case SortFilter.titleDesc:
        return "titleDesc";
      case SortFilter.dateAsc:
        return "dateAsc";
      case SortFilter.dateDesc:
        return "dateDesc";
    }
  }
}
