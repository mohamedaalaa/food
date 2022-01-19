

import 'package:flutter/material.dart';
import 'package:food/models/app_state_manager.dart';
import 'package:food/models/grocery_manager.dart';

import 'package:food/screens/grocery_item_screen.dart';
import 'package:food/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<GroceryManager>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<GroceryManager>(context, listen: false);
          manager.createNewItem();
        },
      ),
      body: buildGroceryScreen(),
    );
  }
}

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),
            Text(
              'No Groceries',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              onPressed: () {
                Provider.of<AppStateManager>(context, listen: false).goToRecipe();
              },
              child: const Text('Browse Recipes'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}



Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(builder: (context, manager, child) {
    if (manager.groceryItem.isEmpty) {
      return const EmptyGroceryScreen();
    } else {
      return GroceryListScreen(manager: manager);
    }
  });
}
