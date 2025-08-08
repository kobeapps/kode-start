class CharacterLocationModel {
  final String name;
  final String url;

  CharacterLocationModel({required this.name, required this.url});

  factory CharacterLocationModel.fromJson(Map<String, dynamic> json) {
    return CharacterLocationModel(
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }
}
