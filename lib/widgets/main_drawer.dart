import 'package:flutter/material.dart';
import 'package:meals/main.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.setScreen});

  final void Function(String identifier) setScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              setScreen('Meals');
            },
            leading: Icon(
              Icons.restaurant,
              size: 28,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          ListTile(
            onTap: () {
              setScreen('Filters');
            },
            leading: Icon(
              Icons.settings,
              size: 28,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          )
        ],
      ),
    );
  }
}
