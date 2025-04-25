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
  });
  @override
  String toString(){
    return 'Restaurant{id: $id, name: $name, category: $category, description: $description, imgUrl: $imgUrl, vidUrl: $vidUrl, delivPrice: $delivPrice, delivTime: $delivTime, rating: $rating, liked: $liked, distance: $distance}';
  }
}
