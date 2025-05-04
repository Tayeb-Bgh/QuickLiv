import 'package:mobileapp/features/customer/research/business/entities/business_entity.dart';
import 'package:mobileapp/features/customer/research/data/repositories/research_repository_impl.dart';

class GetBusinessProducts {
  final ResearchRepositoryImpl researchRepository;

  GetBusinessProducts({required this.researchRepository});

  Future<List<Business>> call(String keyWord, double lat, double lng) {
    return researchRepository.getBusinessesByKeyWord(keyWord, lat, lng);
  }
}
