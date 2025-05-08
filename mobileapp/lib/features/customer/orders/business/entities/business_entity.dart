class Business {
  final int id;
  final String name;
  final String imgUrl;

  Business({required this.id, required this.name, required this.imgUrl});

  

  @override
  String toString() {
   return 'Business{id: $id, name: $name, imgUrl: $imgUrl}';  
   }
}