import 'dart:convert';

import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final String age;
  final String about;
  final String contact;
  final String imageUrl;
  final String membership;
  final String address;

  User({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.about,
    @required this.contact,
    @required this.imageUrl,
    @required this.membership,
    @required this.address,
  });
}

class Users with ChangeNotifier {
  List<User> _items = [
    User(
      id: "User19876",
      name: 'Nishi Kapoor',
      age: '19',
      about: 'Love to see the world',
      contact: '9988776655',
      imageUrl:
          'https://static.businessworld.in/article/article_extra_large_image/1546929785_lRP17s_cropped_97_.png',
      membership: 'Gold',
      address: 'Somewhere on Earth',
    )
  ];

  List<User> get items {
    return [..._items];
  }

//  Product findById(String id) {
//    return _items.firstWhere((prod) => prod.id == id);
//  }

  Future<void> updateProduct(String id, User newUser) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    _items[index] = newUser;
    notifyListeners();
  }
}
