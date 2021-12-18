import 'package:farmx/models/user.dart';
import 'package:farmx/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late final User? user;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String> trySignup(String username, String email, String password) async {
    return await AuthenticationService.signup(username, email, password);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register"), centerTitle: true),
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
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email'
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
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var message = await trySignup(username, email, password) ;

                    if(message != null){
                      Navigator.pushNamed(context, '/login');
                      print("JWTTTTTT: $user");
                      // displayDialog(context,"Success", "here is your jwt");
                    } else {
                      displayDialog(context,"An Error Occurred", "No account was found matching that username and password");
                    }


                  },
                  child: Text("Register")
              ),

              SizedBox(height: 10),
              Row(
                children: [
                  Text("You already have an account?"),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login'),
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


void displayDialog(BuildContext context, String title, String text) =>
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
              title: Text(title),
              content: Text(text)
          ),
    );
