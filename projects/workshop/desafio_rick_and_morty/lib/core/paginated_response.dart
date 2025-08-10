class PageInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const PageInfo(
      {required this.count, required this.pages, this.next, this.prev});

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        count: json['count'] ?? 0,
        pages: json['pages'] ?? 0,
        next: json['next'],
        prev: json['prev'],
      );
}

class PaginatedResponse<T> {
  final PageInfo info;
  final List<T> results;

  PaginatedResponse({required this.info, required this.results});
}
