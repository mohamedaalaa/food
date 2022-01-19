



import 'dart:async';

import 'package:flutter/foundation.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}


class AppStateManager extends ChangeNotifier{

  bool _initialized=false;
  bool _loggedIn=false;
  bool _onboardingComplete=false;
  int _selectedTab=FooderlichTab.explore;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;



  void initializeApp(){
    Timer(const Duration(milliseconds: 2000),(){
      _initialized=true;
      notifyListeners();
    });
  }


  void logIn(String userName,String password){
    _loggedIn=true;
    notifyListeners();
  }


  void completeBoarding(){
    _onboardingComplete=true;
    notifyListeners();
  }

  void goToTab(int index){
    _selectedTab=index;
    notifyListeners();
  }


  void goToRecipe(){
    _selectedTab=FooderlichTab.recipes;
    notifyListeners();
  }

  void logOut(){
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    initializeApp();
    notifyListeners();
  }



}