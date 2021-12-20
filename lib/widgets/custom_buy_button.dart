import 'package:farmx/models/lot.dart';
import 'package:farmx/services/order_service.dart';
import 'package:farmx/widgets/display_dialog.dart';
import 'package:flutter/material.dart';

class CustomBuyButton extends StatelessWidget {
  CustomBuyButton(this.lot);

  late final Lot lot;

  final TextEditingController _amountController = TextEditingController();

  Future<String> placeOrder(int lotId, int amount) async {
    try {
      return await OrderService.placeOrder(lot.id, amount);
    } on Exception catch (e) {
      print(e);
      // return "errrrrrrrrrrrrr from placeOrder() in customBuy ";
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center, // no effect
      width: 150,
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 12),
              controller: _amountController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(),
                  labelText: ' KG'),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
          ),
          SizedBox(width: 5),
          ElevatedButton(
            child: Text("Order"),
            onPressed: () async {
              int? amount = int.tryParse(_amountController.text);
              if (amount != null && amount > 0) {
                var res = await placeOrder(lot.id, amount);
                // if(res !=null)
                displayDialog(context, "Message!", res);
              } else {
                displayDialog(context, "An Error Occurred",
                    "The amount should be more then 0");
              }
            },
          ),
        ],
      ),
    );
  }
}
