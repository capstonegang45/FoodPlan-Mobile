import 'package:flutter_test/flutter_test.dart';
import 'package:food_plan/models/produk.dart';

void main() {
  group('Product', () {
    test('fromJson should create a Product object from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'category_id': 2,
        'ingredients': 'Test Ingredients',
        'steps': 'Test Steps',
        'carbohidrat': 10,
        'fat': 5,
        'protein': 15,
        'description': 'Test Description',
        'category_name': 'Test Category',
        'image_src': 'Test Image'
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.categoryId, 2);
      expect(product.ingredients, 'Test Ingredients');
      expect(product.steps, 'Test Steps');
      expect(product.carbohidrat, 10);
      expect(product.fat, 5);
      expect(product.protein, 15);
      expect(product.description, 'Test Description');
      expect(product.categoryName, 'Test Category');
      expect(product.image_src, 'Test Image');
    });

    test('toJson should convert a Product object to JSON', () {
      final product = Product(
        id: 1,
        title: 'Test Product',
        categoryId: 2,
        ingredients: 'Test Ingredients',
        steps: 'Test Steps',
        carbohidrat: 10,
        fat: 5,
        protein: 15,
        description: 'Test Description',
        categoryName: 'Test Category',
        image_src: 'Test Image',
      );

      final json = product.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Test Product');
      expect(json['category_id'], 2);
      expect(json['ingredients'], 'Test Ingredients');
      expect(json['steps'], 'Test Steps');
      expect(json['carbohidrat'], 10);
      expect(json['fat'], 5);
      expect(json['protein'], 15);
      expect(json['description'], 'Test Description');
      expect(json['category_name'], 'Test Category');
      expect(json['image_src'], 'Test Image');
    });
  });
}