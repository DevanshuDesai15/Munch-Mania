import 'package:food_recommendation/main.dart';

class SearchServiceForDessert {
  Future<List<Map<String, dynamic>>> searchByName(String searchField) async {
    final data = await supabase
        .from('recipes')
        .select()
        .eq('category', 'dessert')
        .eq('search_key', searchField.substring(0, 1).toUpperCase());
    return List<Map<String, dynamic>>.from(data);
  }
}
