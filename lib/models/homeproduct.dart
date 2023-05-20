class ProductDataModel {
  final String id;
  final String name;

  final int price;
  final String imageUrl;
  bool? isCartSelected;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      this.isCartSelected}) {
    isCartSelected = isCartSelected ?? false;
  }

  ProductDataModel copyWith(
          {String? id,
          String? name,
          int? price,
          String? imageUrl,
          bool? isCartSelected}) =>
      ProductDataModel(
          id: id ?? this.id,
          name: name ?? this.name,
          price: price ?? this.price,
          imageUrl: imageUrl ?? this.imageUrl,
          isCartSelected: isCartSelected ?? this.isCartSelected);
}
