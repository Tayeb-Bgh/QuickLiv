class Restaurant {
  final int id;
  final String name;
  final String category;
  final String description;
  final String imgUrl;
  final String vidUrl;

  final double delivPrice;
  final int delivTime;
  final double rating;
  final bool liked;
  final double distance;

  final String? insta;
  final String? fcb;
  final String? phone;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imgUrl,
    required this.vidUrl,
    required this.delivPrice,
    required this.delivTime,
    required this.rating,
    required this.liked,
    required this.distance,
    required this.insta,
    required this.fcb,
    required this.phone,
  });
  @override
  String toString() {
    return 'Restaurant{id: $id, name: $name, category: $category, description: $description, imgUrl: $imgUrl, vidUrl: $vidUrl, delivPrice: $delivPrice, delivTime: $delivTime, rating: $rating, liked: $liked, distance: $distance}';
  }
}
