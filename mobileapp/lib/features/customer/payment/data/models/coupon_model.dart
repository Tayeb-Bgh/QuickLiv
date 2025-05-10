class CouponModel {
  final int idCoupon;
  final double reducRateCoupon;
  final String reducCodeCoupon;
  final bool isUsedCoup;
  final int idCustCoupon;

  CouponModel({
    required this.idCoupon,
    required this.reducCodeCoupon,
    required this.reducRateCoupon,
    required this.isUsedCoup,
    required this.idCustCoupon,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      idCoupon: json["idCoupon"],
      reducRateCoupon: json["reducRateCoupon"].toDouble(),
      reducCodeCoupon: json["reducCodeCoupon"],
      idCustCoupon: json["idCustCoupon"],
      isUsedCoup: json["isUsedCoup"] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idCoupon": idCoupon,
      "reducCodeCoupon": reducCodeCoupon,
      "reducRateCoupon": reducRateCoupon,
      "isUsedCoup": isUsedCoup,
      "idCustCoupon": idCustCoupon,
    };
  }
}
