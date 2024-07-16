class ProductCard {
  ProductCard(
      {required this.name,
      required this.category,
      required this.price,
      required this.rating,
      required this.description,
      required this.id,
      required this.imageUrl,
      this.imageUrl2,
      this.imageUrl3,
      required this.articleNumber,
      required this.color,
      required this.composition,
      required this.countryOfOrigin,
      required this.season});
  final int id;
  final String name;
  final String category;
  final int price;
  final double rating;
  final String imageUrl;
  final String description;
  final String? imageUrl2;
  final String? imageUrl3;
  final String composition;
  final String season;
  final String color;
  final String countryOfOrigin;
  final String articleNumber;
  factory ProductCard.fromJson(Map<String, dynamic> json) {
    return ProductCard(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
        rating: json['rating'],
        imageUrl: json['imageUrl'],
        description: json['description'],
        imageUrl2: json['imageUrl2'],
        imageUrl3: json['imageUrl3'],
        composition : json['composition'],
        season: json['season'],
        color: json['color'],
        countryOfOrigin: json['countryOfOrigin'],
        articleNumber: json['articleNumber']
        );
  }
   
}


