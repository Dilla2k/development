class ShoppingCartItem {
  String? id;
  final String productName;
  int count;
  final String? additionalIndigrend;
  final double price;
  final int? size;
  final int? countPayed;

  ShoppingCartItem({
    this.id,
    required this.count,
    required this.productName,
    this.additionalIndigrend,
    this.size,
    required this.price,
    this.countPayed,
  });
}
