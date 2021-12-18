import 'package:farmx/models/user.dart';
import 'package:farmx/services/auth_services.dart';
import 'package:farmx/widgets/display_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final User? user;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<User> trySignin(String username, String password) async {
    return await AuthenticationService.signin(username, password);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"), centerTitle: true),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('FarmX', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.text_fields),
                  labelText: 'Username'
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password),
                  labelText: 'Password'
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var username = _usernameController.text;
                  var password = _passwordController.text;
                  user = await trySignin(username, password);

                  if(user != null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => HomePage()
                    //TODO: from home iniTState() send request to get all available lots for the user and display list
                         )
                    );
                    print("JWTTTTTT: $user");
                    // displayDialog(context,"Success", "here is your jwt");
                  } else {
                    displayDialog(context,"An Error Occurred", "No account was found matching that username and password");
                  }


                },
                child: Text("Login")
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Text("Don't you have an account?"),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Register'),
                  autofocus: true,
                  style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.green))
                ),)
              ],
            )
          ],
        ),
      )
    );
  }
}


