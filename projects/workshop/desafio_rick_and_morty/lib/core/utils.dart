int? idFromUrl(String url) {
  final parts = url.split('/').where((e) => e.isNotEmpty).toList();
  return int.tryParse(parts.isNotEmpty ? parts.last : '');
}
