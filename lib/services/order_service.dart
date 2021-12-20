import 'dart:convert';
import 'package:farmx/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  static final BASE_URL = "https://farmx-springboot-api.herokuapp.com/api";

  static Future<String> placeOrder(int lotId, int amount) async {
    var url = "$BASE_URL/lots/$lotId/orders/$amount";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if(token == null) throw Exception("You aren't authorized to place an order, please sign in and try again!");

    var respone = await http.post(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (respone.statusCode == 201) {
      print(respone.body);
      return respone.body;
    } else {
      throw Exception("Failed to place an order");
    }
  }


  static Future<List<Order>> fetchOrdersByUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var username = prefs.getString("username");

    var response = await http.get(Uri.parse("$BASE_URL/orders/$username"),
        headers: {
          "Accept-type": "application/json",
          'Authorization': 'Bearer $token'
        });
    print('Response body from fetchOrdersByUsername(): ${response.body}');
    print("$BASE_URL/orders/$username");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;
      print("Json Response List<order> length: ${jsonResponse.length}");

      var list = jsonResponse.map((value) => Order.fromJson(value)).toList();
      return list;
    } else {
      throw Exception("Failed to fetch orders from API");
    }
  }

}
