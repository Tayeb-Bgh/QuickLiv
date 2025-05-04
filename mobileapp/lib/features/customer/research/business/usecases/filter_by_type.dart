import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';

class FilterByType {
  List<Business> call(List<Business> businessList, String? type) {
    return type != null
        ? businessList.where((business) => business.type == type).toList()
        : businessList;
  }
}
