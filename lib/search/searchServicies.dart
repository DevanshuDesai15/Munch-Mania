import 'package:food_recommendation/main.dart';

class SearchService {
  Future<List<Map<String, dynamic>>> searchByName(String searchField) async {
    final data = await supabase
        .from('products')
        .select()
        .eq('search_key', searchField.substring(0, 1).toUpperCase());
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> searchByButtonName(
      List searchField) async {
    print(searchField);
    final data = await supabase
        .from('products')
        .select()
        .overlaps('search_criteria', searchField);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<List<Map<String, dynamic>>> searchByButtonType(
      String searchField) async {
    searchField = searchField.toLowerCase();
    if (searchField == "fruit" || searchField == "fruits") {
      searchField = "Fruit";
    } else if (searchField == "vegetable" ||
        searchField == "vegetables" ||
        searchField == "veg") {
      searchField = "Vegetable";
    } else if (searchField == "masala" ||
        searchField == "spices" ||
        searchField == "spice" ||
        searchField == "masalas") {
      searchField = "Masala";
    } else if (searchField == "meat" ||
        searchField == "non-veg" ||
        searchField == "non veg") {
      searchField = "Meat";
    } else if (searchField == "canned" || searchField == "can") {
      searchField = "Canned";
    } else if (searchField == "bakery" ||
        searchField == "baked" ||
        searchField == "bake") {
      searchField = "Bakery";
    } else if (searchField == "dairy" ||
        searchField == "milk products" ||
        searchField == "milk product") {
      searchField = "Dairy";
    }
    print(searchField);
    final data = await supabase
        .from('products')
        .select()
        .eq('type_of_product', searchField);
    return List<Map<String, dynamic>>.from(data);
  }
}
