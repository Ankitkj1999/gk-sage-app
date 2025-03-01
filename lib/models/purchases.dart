class PurchaseModel {
  final String userId,
      userName,
      userEmail,
      productId,
      productTitle,
      price,
      platform;
  final int points;
  final DateTime purchaseAt;

  PurchaseModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.productId,
    required this.productTitle,
    required this.purchaseAt,
    required this.points,
    required this.price,
    required this.platform,
  });

  static Map<String, dynamic> getMap(PurchaseModel d) {
    return {
      'user_id': d.userId,
      'user_name': d.userName,
      'user_email': d.userEmail,
      'product_id': d.productId,
      'product_title': d.productTitle,
      'purchase_at': d.purchaseAt,
      'points': d.points,
      'price': d.price,
      'platform': d.platform,
    };
  }
}
