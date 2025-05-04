class ProductGridModel {
  final List<String> images;
  final String brandName;
  final String rating;
  final String prdName;
  final String price;
  late int quantity;
  final String id;
  final bool ShouldVisible;
   bool isFavourite;

  ProductGridModel({
    required this.images,
    required this.brandName,
    required this.rating,
    required this.prdName,
    required this.price,
    required this.quantity,
    required this.ShouldVisible,
    required this.id,
    required this.isFavourite,
  });
}
