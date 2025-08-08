class OriginModel {
  OriginModel({required this.name, required this.url});

  final String name;
  final String url;

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }
}
