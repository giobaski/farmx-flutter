import 'dart:convert';

import 'package:farmx/models/lot.dart';
import 'package:farmx/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LotService {
  // static final BASE_URL = "http://b02d-62-65-196-174.ngrok.io/api";
  static final BASE_URL = "https://farmx-springboot-api.herokuapp.com/api";


  static Future<List<Lot>> fetchAllLots() async {
    var response = await http.get(Uri.parse("$BASE_URL/lots"),
        headers: {
          "Accept-type": "application/json"
        });
    print('Response body: ${response.body}');


    if(response.statusCode == 200){
      final jsonResponse = jsonDecode(response.body) as List;
      print("Json Response List<Lot> length: ${jsonResponse.length}");

      var list = jsonResponse.map((value) => Lot.fromJson(value)).toList();
      return list;
    }else {
      throw Exception("Failed to fetch lots");
    }

}



// you need token to send request
 static Future<String> placeOrder(int lotId, int amount) async {
    var url = "$BASE_URL/lots/$lotId/orders/$amount";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    var respone = await http.post(Uri.parse(url),
    headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    }
    );

    if (respone.statusCode == 201){
      print(respone.body);
      return respone.body;
    } else {
      throw Exception("Failed to place an order");
    }



 }

// getLotsByUsername()


}