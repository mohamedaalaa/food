import 'package:flutter/cupertino.dart';
import 'package:food/home.dart';
import 'package:food/models/app_state_manager.dart';
import 'package:food/models/fooderlich_pages.dart';
import 'package:food/models/grocery_manager.dart';
import 'package:food/models/profile_manager.dart';
import 'package:food/screens/grocery_item_screen.dart';
import 'package:food/screens/login_screen.dart';
import 'package:food/screens/onboarding_screen.dart';
import 'package:food/screens/profile_screen.dart';
import 'package:food/screens/splash_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  // TODO: implement navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;

  // 3
  final AppStateManager appStateManager;
  // 4
  final GroceryManager groceryManager;
  // 5
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager}):navigatorKey=GlobalKey<NavigatorState>(){
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }
  
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)LoginScreen.page(),
        if( appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        if(appStateManager.isOnboardingComplete) Home.page(appStateManager.getSelectedTab),
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: (item) {
              // 3
              groceryManager.addItem(item);
            }, onUpdate: (item, index) {
            // 4 No update
          },
          ),
        if (groceryManager.selectedIndex != -1)
        // 2
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                // 3
                groceryManager.updateItem(item, index);
              },
              onCreate: (_) {
                // No create
              }),
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),

      ],
    );
  }

  bool _handlePopPage(Route<dynamic>route,result){
    if(!route.didPop(result)){
      return false;
    }

    // 5
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logOut();
    }
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }
    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    // TODO: Handle state when user closes WebView screen
    // 6

    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
