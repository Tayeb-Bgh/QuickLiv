class Favourite {
  final int idCustFav;
  final int idBusnsFav; 
  
  Favourite({required this.idCustFav, required this.idBusnsFav});

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      idCustFav: json['idCustFav'] as int,
      idBusnsFav: json['idBusnsFav'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCustFav': idCustFav,
      'idBusnsFav': idBusnsFav,
    };
  }
   Favourite toEntity() {
    return Favourite(
      idCustFav: idCustFav,
      idBusnsFav: idBusnsFav,
    );
  }
}