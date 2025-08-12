import 'dart:convert';

class Info {
  final int count;
  final int pages;
  final String? next; 
  final String? prev; 

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  Info copyWith({
    int? count,
    int? pages,
    String? next,
    String? prev,
  }) {
    return Info(
      count: count ?? this.count,
      pages: pages ?? this.pages,
      next: next ?? this.next,
      prev: prev ?? this.prev,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: (map['count'] as num).toInt(),
      pages: (map['pages'] as num).toInt(),
      next: map['next'] as String?, 
      prev: map['prev'] as String?, 
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Info(count: $count, pages: $pages, next: $next, prev: $prev)';

  @override
  bool operator ==(covariant Info other) {
    if (identical(this, other)) return true;
    return other.count == count &&
        other.pages == pages &&
        other.next == next &&
        other.prev == prev;
  }

  @override
  int get hashCode => count.hashCode ^ pages.hashCode ^ next.hashCode ^ prev.hashCode;
}
