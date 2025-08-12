import 'dart:convert';

import 'package:collection/collection.dart';

import 'info.dart';
import 'result.dart';

class ListRickyAndMortyDatas {
  final Info info;
  final List<Result> results;
  ListRickyAndMortyDatas({
    required this.info,
    required this.results,
  });

  ListRickyAndMortyDatas copyWith({
    Info? info,
    List<Result>? results,
  }) {
    return ListRickyAndMortyDatas(
      info: info ?? this.info,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory ListRickyAndMortyDatas.fromMap(Map<String, dynamic> map) {
    return ListRickyAndMortyDatas(
      info: Info.fromMap(map['info'] as Map<String,dynamic>),
      results: List<Result>.from((map['results'] as List<int>).map<Result>((x) => Result.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListRickyAndMortyDatas.fromJson(String source) =>ListRickyAndMortyDatas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'List_ricky_and_morty_datas(info: $info, results: $results)';

  @override
  bool operator ==(covariant ListRickyAndMortyDatas other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.info == info &&
      listEquals(other.results, results);
  }

  @override
  int get hashCode => info.hashCode ^ results.hashCode;
}