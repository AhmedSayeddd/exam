class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final int reviews;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      rating: json['rating'] != null ? json['rating']['rate'].toDouble() : 4.5,
      reviews: json['rating'] != null ? json['rating']['count'] : 132,
    );
  }
}
