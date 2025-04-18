
class Shoe {
  final String id;
  final String name;
  final List<String> imageUrl;
  final double price;
  final String description;
  final String size;
  late final int inStock;
  final int maxBuy;
  final DateTime dateSell;


  Shoe({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.size,
    required this.inStock,
    required this.maxBuy,
    required this.dateSell,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
        'size': size,
        'inStock': inStock,
        'maxBuy': maxBuy,
        'dateSell': dateSell.toIso8601String(),
      };


  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'],
      name: json['name'],
      imageUrl: List<String>.from(json['imageUrl']),
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock: json['inStock'] is String ? int.parse(json['inStock']) : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
    );
  }

}

class DetailShoe extends Shoe {
  DetailShoe({
    required String id,
    required String name,
    required List<String> imageUrl,
    required double price,
    required String description,
    required String size,
    required int inStock,
    required int maxBuy,
    required DateTime dateSell,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          description: description,
          size: size,
          inStock: inStock,
          maxBuy: maxBuy,
          dateSell: dateSell,
        );
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
        'size': size,
        'inStock': inStock,
        'maxBuy': maxBuy,
        'dateSell': dateSell.toIso8601String(),
      };
  factory DetailShoe.fromJson(Map<String, dynamic> json) {
    return DetailShoe(
      id: json['id'],
      name: json['name'],
      imageUrl: List<String>.from(json['imageUrl']),
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock: json['inStock'] is String ? int.parse(json['inStock']) : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
    );
  }
}

 class ShoeInCart extends Shoe {
  int quantity;

  ShoeInCart({
    required String id,
    required String name,
    required List<String> imageUrl,
    required double price,
    required String description,
    required String size,
    required int inStock,
    required int maxBuy,
    required DateTime dateSell,
    this.quantity = 1,
  })
      : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          description: description,
          size: size,
          inStock: inStock,
          maxBuy: maxBuy,
          dateSell: dateSell,
        );
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
        'quantity': quantity,
        'size': size,
        'inStock': inStock,
        'maxBuy': maxBuy,
        'dateSell': dateSell.toIso8601String(),
      };
  factory ShoeInCart.fromJson(Map<String, dynamic> json) {
    return ShoeInCart(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock: json['inStock'] is String ? int.parse(json['inStock']) : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
      quantity: json['quantity'] ?? 1,
    );
  }
 }