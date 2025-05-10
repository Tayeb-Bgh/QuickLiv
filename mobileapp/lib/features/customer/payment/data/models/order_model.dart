class OrderModel {
  final double delivPriceOrd;
  final String weightCatOrd;
  final int? ratingDelOrd;
  final int? ratingBusnsOrd;
  final int statusOrd;
  final double custLatOrd;
  final double custLngOrd;
  final double? delLatOrd;
  final double? delLngOrd;
  final bool cancelCustOrd;
  final bool cancelDelOrd;
  final int idCartOrd;
  final int? idCouponOrd;
  final int? transNbrOrd;

  OrderModel({
    required this.idCartOrd,
    required this.delivPriceOrd,
    required this.weightCatOrd,
    required this.custLatOrd,
    required this.custLngOrd,
    required this.idCouponOrd,
    this.ratingDelOrd,
    this.ratingBusnsOrd,
    this.delLatOrd,
    this.delLngOrd,
    this.transNbrOrd,
    this.statusOrd = 0,
    this.cancelCustOrd = false,
    this.cancelDelOrd = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCartOrd': idCartOrd,
      'delivPriceOrd': delivPriceOrd,
      'weightCatOrd': weightCatOrd,
      'transNbrOrd': transNbrOrd,
      'ratingDelOrd': ratingDelOrd,
      'ratingBusnsOrd': ratingBusnsOrd,
      'statusOrd': statusOrd,
      'custLatOrd': custLatOrd,
      'custLngOrd': custLngOrd,
      'delLatOrd': delLatOrd,
      'delLngOrd': delLngOrd,
      'cancelCustOrd': cancelCustOrd,
      'cancelDelOrd': cancelDelOrd,
      'idCouponOrd': idCouponOrd,
    };
  }
}
