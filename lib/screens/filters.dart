import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({super.key, required this.setedFilters});

  Map<Filter, bool> setedFilters;

  @override
  State<FiltersScreen> createState() {
    return FiltersScreenState();
  }
}

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;
  var _lactoseFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.setedFilters[Filter.glutenFree]!;
    _vegetarianFilterSet = widget.setedFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.setedFilters[Filter.vegan]!;
    _lactoseFilterSet = widget.setedFilters[Filter.lactoseFree]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Filters',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include gluted-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              value: _glutenFreeFilterSet,
              onChanged: (val) {
                setState(() {
                  _glutenFreeFilterSet = val;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegetarian meals',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              value: _vegetarianFilterSet,
              onChanged: (val) {
                setState(() {
                  _vegetarianFilterSet = val;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              value: _veganFilterSet,
              onChanged: (val) {
                setState(() {
                  _veganFilterSet = val;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              value: _lactoseFilterSet,
              onChanged: (val) {
                setState(() {
                  _lactoseFilterSet = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
