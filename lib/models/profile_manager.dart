

import 'package:flutter/cupertino.dart';
import 'package:food/models/user.dart';

class ProfileManager extends ChangeNotifier{


  User get getUser=> User(firstName: 'Stef',
    lastName: 'Patt',
    role: 'Flutterista',
    profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
    points: 100,
    darkMode: _darkMode,);

  var _darkMode=false;

  var _didSelectUser=false;

  var _tapOnRaywenderlich = false;

  bool get didSelectUser =>_didSelectUser;

  bool get darkMode => _darkMode;

  bool get didTapOnRaywenderlich => _tapOnRaywenderlich;



  void set darkMode(bool value){
    _darkMode=value;
    notifyListeners();
  }


  void tapOnProfile(bool selected){
    _didSelectUser=selected;
    notifyListeners();
  }

  void tapOnRaywenderlich(bool selected) {
    _tapOnRaywenderlich = selected;
    notifyListeners();
  }

}