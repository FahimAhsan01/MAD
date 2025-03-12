import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemProvider extends ChangeNotifier { // Use `extends` instead of `with`
  final List<Item> _items = [
    Item(name: 'Item 1'),
    Item(name: 'Item 2'),
    Item(name: 'Item 3'),
  ];

  List<Item> get items => _items;

  void toggleFavorite(int index) {
    _items[index].isFavorite = !_items[index].isFavorite;
    notifyListeners();
  }

  void addItem(String name) {
    _items.add(Item(name: name));
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}