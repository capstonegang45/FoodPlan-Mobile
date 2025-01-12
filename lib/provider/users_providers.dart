import 'package:flutter/material.dart';
import 'package:food_plan/models/user.dart';
import 'package:food_plan/models/produk.dart';
import 'package:food_plan/helpers/beranda_helper.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  List<Product> _matchingProducts = [];
  List<Product> _otherProducts = [];

  User? get user => _user;
  List<Product> get matchingProducts => _matchingProducts;
  List<Product> get otherProducts => _otherProducts;

  Future<void> loadData() async {
    // Mengambil data pengguna dan produk
    try {
      final data = await getUserProfileAndProducts();
      _user = User.fromJson(data['user']);
      _matchingProducts = (data['products']['matching_products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      _otherProducts = (data['products']['other_products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      notifyListeners(); // Memberitahukan kepada widget yang menggunakan provider
    } catch (e) {
      // Handle error jika diperlukan
    }
  }
}
