import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

final Map<Filter, bool> kFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentIndex = 0;

  Map<Filter, bool> choosenFilters = kFilters;


  late Widget currentScreen =
      CategoriesScreen(filteredMealss: ref.read(mealsProvider),);

  void _changeScreens(int index) {
    final favoritesList = ref.watch(favoriteMealsProvider);
    final mealss = ref.watch(mealsProvider);
    List<Meal> meals = mealss.where((meal) {
      if (choosenFilters[Filter.vegetarian]! && meal.isVegetarian) {
        return false;
      }
      if (choosenFilters[Filter.vegan]! && meal.isVegan) {
        return false;
      }
      if (choosenFilters[Filter.lactoseFree]! && meal.isLactoseFree) {
        return false;
      }
      if (choosenFilters[Filter.glutenFree]! && meal.isGlutenFree) {
        return false;
      }
      return true;
    }).toList();
    setState(() {
      _currentIndex = index;

    });
    if(_currentIndex == 1) {
      currentScreen = MealsScreen(meals: favoritesList);
    } else {
      currentScreen = CategoriesScreen(filteredMealss: meals);
    }
  }

  @override
  Widget build(BuildContext context) {
    void switchScreens(String screenName) async {
      Navigator.of(context).pop();
      if (screenName == 'Filters') {
        final value = await Navigator.push<Map<Filter, bool>>(
            context, MaterialPageRoute(builder: (ctx) => FiltersScreen(setedFilters: choosenFilters)));
        setState(() {
          choosenFilters = value ?? kFilters;
          _changeScreens(0);
        });
      }
    }

    String title = 'Categories';

    if (_currentIndex == 1) {
      title = 'Your Favorite Meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        setScreen: switchScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeScreens,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
      body: currentScreen,
    );
  }
}
