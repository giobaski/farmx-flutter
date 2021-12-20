import 'dart:ui';

import 'package:farmx/models/Lot.dart';
import 'package:farmx/services/lot_service.dart';
import 'package:farmx/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'lot_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? email;
  late Future<List> _futureLots;
  bool isFavouriteLot = false;
  List<Lot> wishlist = [];

  void loginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      username = sharedPreferences.getString("username");
      email = sharedPreferences.getString("email");
    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      //     (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    //if user hasn't the token in SP, redirect to the login page!
    loginStatus();

    _futureLots = LotService.fetchAllLots();
  }

  // welcome Username,
  // your assets on a card, predicted revenue
  //
  // list of lots

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Home'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
              )
            ]),
        drawer: CustomDrawer(username: username ?? "Guest User", email: email ?? "guest@gmail.com"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                  color: Colors.teal,
                ),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Farm',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'X',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            TextSpan(text: ' Estonia!'),
                          ],
                        ),
                      )
                      // Text('FarmX Estonia',
                      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
                      // ),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: username != null
                        ? Text("Hello $username".toUpperCase(),
                              style: TextStyle(color: Colors.white),)
                        : SizedBox(
                      height: 18,
                      child: ElevatedButton(
                        // style: style,
                        onPressed: () {Navigator.pushNamed(context, "/register");},
                        child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                    // Text("Hello Guest"),
                  ),
                ]),
              ),

              //Search input
              SizedBox(height: 12),
              Container(
                width: 100,
                height: 30,
                child: TextField(
                  // controller: _searchController,
                  decoration: InputDecoration(
                      suffix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(),
                      labelText: 'search'),
                ),
              ), //search Container

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Lots',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _futureLots = LotService.fetchAllLots();
                          });
                        },
                        child: Text(
                          "Update list",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ),

              Container(
                height: 300,
                child: FutureBuilder<List>(
                  future: _futureLots,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.runtimeType);
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) => Card(
                          elevation: 10,
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: Text(
                                    "Lot #${snapshot.data![index].id}",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold)),
                                // Icon(Icons.agriculture_outlined),
                                title: Text(snapshot.data![index].productName),
                                //.pname
                                subtitle:
                                    Text(snapshot.data![index].description),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LotDetailsPage(
                                              snapshot.data![index])));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        snapshot.data![index].currentAmount
                                                .toString() +
                                            " KG",
                                        style: TextStyle(
                                            color: Colors.white,
                                            backgroundColor: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        snapshot.data![index].openingPrice
                                                .toString() +
                                            "\$ -> " +
                                            snapshot.data![index].closingPrice
                                                .toString() +
                                            "\$",
                                        style: TextStyle(
                                            color: Colors.white,
                                            backgroundColor: Colors.red[500],
                                            fontWeight: FontWeight.bold)),
                                    Row(children: [
                                      Icon(Icons.lock_clock,
                                          color: Colors.teal, size: 14),
                                      Text(
                                          " " +
                                              snapshot.data![index].closingDate,
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              //.desc ['description']

                              // IconButton(
                              //   icon: Icon(wishlist.contains(snapshot.data![index])? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                              //   onPressed: (){
                              //     setState((){
                              //       wishlist.add(snapshot.data![index]);
                              //       // isFavouriteLot = !isFavouriteLot;
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('has error: ${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    // return const CircularProgressIndicator();
                    return Text("loading...");
                  },
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggested Lots',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                ),
              ),

              Divider(),

              InkWell(
                onTap: () {
                  //open new screen where you explain how trading works
                },
                child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50)),
                      // color: Colors.teal,
                    ),
                    child: Center(
                      child: Image.asset('assets/images/work.png',
                          fit: BoxFit.cover),
                    )),
              ),
            ],
          ),
        ));
  }
}

// class customListTile extends StatelessWidget {
//   final Lot item;
//   customListTile(this.item);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//
//       contentPadding: const EdgeInsets.all(10),
//       // title: Text('productName'),
//       // subtitle: Text('description'),
//       title: Text(item.productName),
//       subtitle: Text(item.description),
//     );
//   }
// }
