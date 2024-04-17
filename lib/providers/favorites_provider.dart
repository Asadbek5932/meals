import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toogleMealFavoriteStatus(Meal meal) {
    final mealFavorite = state.contains(meal);
    if(mealFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }

}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});