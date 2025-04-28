import 'package:mobileapp/features/customer/grocery_opened/data/repositories/grocery_opened_repository_impl.dart';

class GetSecondCategories {
  final GroceryOpenedRepositoryImpl groceryOpenedRepository;

  GetSecondCategories({required this.groceryOpenedRepository});

  Future<List<String>> call(int idGroc, String category) {
    return groceryOpenedRepository.getSecondCategories(idGroc, category);
  }
}
