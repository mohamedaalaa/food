
import 'package:flutter/material.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier{
  final List<GroceryItem> _groceryItem=[];
  bool _createNewItem = false;
  int _selectedIndex = -1;

  GroceryItem? get selectedGroceryItem =>
      _selectedIndex != -1 ? _groceryItem[_selectedIndex] : null;

  List<GroceryItem> get groceryItem=> List.unmodifiable(_groceryItem);

  int get selectedIndex => _selectedIndex;


  bool get isCreatingNewItem => _createNewItem;


  void groceryItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index){
    _groceryItem.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item){
    _groceryItem.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item,int index){
    _groceryItem[index]=item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItem[index];
    _groceryItem[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }


}