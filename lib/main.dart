import 'package:flutter/material.dart';
import 'package:food/models/app_state_manager.dart';
import 'package:food/models/grocery_manager.dart';
import 'package:food/models/profile_manager.dart';
import 'package:food/models/tab_manager.dart';
import 'package:food/navigation/app_router.dart';

import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  late AppRouter _appRouter;
  final _appStateManager = AppStateManager();
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
        groceryManager: _groceryManager,
        appStateManager: _appStateManager,
        profileManager: _profileManager);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => GroceryManager()),
          ChangeNotifierProvider(create: (context) => _appStateManager)
        ],
        child: Router(
          routerDelegate: _appRouter,
          // TODO: Add backButtonDispatcher
        ),
      ),
    );
  }
}
