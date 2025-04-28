import 'package:mobileapp/features/customer/grocery_opened/data/repositories/grocery_opened_repository_impl.dart';

class GetCategories {
  final GroceryOpenedRepositoryImpl groceryOpenedRepository;

  GetCategories({required this.groceryOpenedRepository});

  Future<List<String>> call(int idGroc) {
    return groceryOpenedRepository.getCategories(idGroc);
  }
}
