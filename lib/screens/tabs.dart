import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;

  final List<Meal> favoritesList = [];
  Map<Filter, bool> choosenFilters = kFilters;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toogleTheFavoritesList(Meal meal) {
    if (favoritesList.contains(meal)) {
      setState(() {
        favoritesList.remove(meal);
        currentScreen = MealsScreen(
            meals: favoritesList, onToggleFavorite: _toogleTheFavoritesList);
        _showMessage(context, 'Successfully removed');
      });
    } else {
      setState(() {
        favoritesList.add(meal);
        _showMessage(context, 'Successfully added');
      });
    }
  }

  late Widget currentScreen =
      CategoriesScreen(onToggleFavorite: _toogleTheFavoritesList, filteredMealss: dummyMeals,);

  void _changeScreens(int index) {
    List<Meal> meals = dummyMeals.where((meal) {
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
      currentScreen = index == 0
          ? CategoriesScreen(onToggleFavorite: _toogleTheFavoritesList, filteredMealss: meals)
          : MealsScreen(
              meals: favoritesList, onToggleFavorite: _toogleTheFavoritesList);
    });
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
