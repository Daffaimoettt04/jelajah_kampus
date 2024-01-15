class Kampus {
  final String name;
  final String location;
  final String description;
  final String built;
  final String type;
  final String buka;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;


  Kampus({
    required this.name,
    required this.location,
    required this.description,
    required this.built,
    required this.type,
    required this.buka,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });
}
