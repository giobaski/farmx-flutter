import 'lot.dart';

class Order{
  final int id;
  final String? description;
  final int amount;
  final String? orderDateTime;
  final Lot lot;

  Order(
      { required this.id,
        required this.description,
        required this.amount,
        required this.orderDateTime,
        required this.lot,
      });


  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
        id: json['id'] as int,
        description: json['description'] as String?,
        amount: json['amount'] as int,
        orderDateTime: json['orderDateTime'] as String?,
        lot: Lot.fromJson(json['lot'])
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, description: $description, amount: $amount, orderDateTime: $orderDateTime, lot: $lot}';
  }
}