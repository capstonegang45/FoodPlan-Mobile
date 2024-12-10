class Product {
  final int id;
  final String title;
  final int categoryId;
  final String ingredients;
  final String steps;
  final int carbohidrat;
  final int fat;
  final int protein;
  final String description;
  final String categoryName;
  // ignore: non_constant_identifier_names
  final String image_src; // Bisa null jika tidak ada gambar

  // Constructor
  Product({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.ingredients,
    required this.steps,
    required this.carbohidrat,
    required this.fat,
    required this.protein,
    required this.description,
    required this.categoryName,
    // ignore: non_constant_identifier_names
    required this.image_src,
  });

  // Factory method untuk membuat objek dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      carbohidrat: json['carbohidrat'],
      fat: json['fat'],
      protein: json['protein'],
      description: json['description'],
      image_src: json['image_src'], // Dapat null, jadi tidak perlu required
    );
  }

  // Method untuk mengubah objek menjadi JSON (misalnya untuk mengirim data ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category_id': categoryId,
      'category_name': categoryName,
      'ingredients': ingredients,
      'steps': steps,
      'carbohidrat': carbohidrat,
      'fat': fat,
      'protein': protein,
      'description': description,
      'image_src': image_src,
    };
  }
}
