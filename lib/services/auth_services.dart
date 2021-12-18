import 'dart:convert';

import 'package:farmx/models/user.dart';
import 'package:farmx/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  // static final BASE_URL = "http://10.0.2.2:8080/api/auth";
  // static final BASE_URL = "http://b02d-62-65-196-174.ngrok.io/api/auth";
  static final BASE_URL = "https://farmx-springboot-api.herokuapp.com/api/auth";




  static Future<User> signin(String username, String password) async {
    var response = await http.post(Uri.parse("$BASE_URL/signin"),
    body: jsonEncode({
      "username": "$username",
      "password": "$password"
    }),
    headers: <String, String>{
      "Content-type": "application/json"
    }
    );

    if(response.statusCode==200){
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print('Response ${response.body}');
      SharedPrefrence().setUserId(jsonResponse['id'].toString());
      SharedPrefrence().setUsername(jsonResponse['username']);
      SharedPrefrence().setEmail(jsonResponse['email']);
      SharedPrefrence().setToken(jsonResponse['accessToken']);
      SharedPrefrence().setLoggedIn(true);

      //add try/catch
      return User.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to login");
    }
  }

  static Future<String> signup(String username, String email, String password) async {
    var response = await http.post(Uri.parse("$BASE_URL/signup"),
        body: jsonEncode({
          "username": "$username",
          "email": "$email",
          "password": "$password"
        }),
        headers: <String, String>{
          "Content-type": "application/json"
        }
    );

    if (response.statusCode == 200) {
      var decodedResponse= jsonDecode(response.body) as Map;
      print(decodedResponse);
      print(decodedResponse.runtimeType);
      return decodedResponse['message'];
    } else {
      throw Exception("Failed to signup");
    }
  }

}