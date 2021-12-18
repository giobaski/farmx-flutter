class Lot {
  final int id;
  final String productName;
  final String description;
  // final User seller;
  // final List<Order> orders;
  // int? initAmount;
  final int? currentAmount;
  final double? openingPrice;
  final double? closingPrice;
  // final String? openingDate;
  final String? closingDate;

  Lot(
      { required this.id, required this.productName, required this.description,
        required this.currentAmount,
        required this.openingPrice,
        required this.closingPrice,
        // required this.openingDate,
        required this.closingDate
      });


  factory Lot.fromJson (Map<String, dynamic> json) {
    return Lot(
      id: json['id'] as int,
      productName: json['productName'] as String,
      description: json['description'] as String,
      currentAmount: json['currentAmount'] as int?,
      openingPrice: json['openingPrice'] as double,
      closingPrice: json['closingPrice'] as double?,
      // openingDate: json['openingDate'] as String?,
      closingDate: json['closingDate'] as String?
    );
  }

  @override
  String toString() {
    return 'Lot{id: $id, productName: $productName, description: $description, currentAmount: $currentAmount, openingPrice: $openingPrice, closingPrice: $closingPrice, closingDate: $closingDate}';
  }
}