import 'package:rick_morty_thiago_arend/models/character.dart';

class PaginatedCharacters {
  PaginatedCharacters({
    required this.info,
    required this.results,
  });

  final Info? info;
  final List<Character> results;

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json){
    return PaginatedCharacters(
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
      results: json["results"] == null ? [] : List<Character>.from(json["results"]!.map((x) => Character.fromJson(x))),
    );
  }
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  final int? count;
  final int? pages;
  final String? next;
  final String? prev;

  factory Info.fromJson(Map<String, dynamic> json){
    return Info(
      count: json["count"],
      pages: json["pages"],
      next: json["next"],
      prev: json["prev"],
    );
  }
}
