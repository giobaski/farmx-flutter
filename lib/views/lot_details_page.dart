import 'package:farmx/models/lot.dart';
import 'package:farmx/widgets/custom_buy_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class LotDetailsPage extends StatelessWidget {
  LotDetailsPage(this.lot);
  late final Lot lot;

  //Todo: Retrieve image urls from database
  final List<String> imageList = [
    "https://www.xda-developers.com/files/2020/02/google-maps-new-logo.jpg",
    "https://wwfint.awsassets.panda.org/img/juhan_sargava_449841.png",
    "http://bnn-news.com/wp-content/uploads/2018/12/ruauuuuaaaaaaaaaaaa.jpg",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F9%2F2019%2F07%2Fyoutube-farmers-FT-BLOG0719.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRRw61DduQSoqeDmfBU44lyRZUl_HQsoLgTAGkwTvpO-4TO0wIPPtY5ToctxvXDSOzq2U&usqp=CAU"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lot #${lot.id}")),
      body: SingleChildScrollView(
        child: Column(
            children: [

              SizedBox(height: 12),

              CarouselSlider(
                options: CarouselOptions(height: 200.0, autoPlay: true),
                items: imageList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Image.network(i,
                              fit: BoxFit.cover
                          ),
                      );
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 12),

              Card(
                // color: Colors.teal,
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(lot.productName,
                        style: TextStyle(fontSize: 22, color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // decoration: BoxDecoration(color: Colors.green),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available amount: ${lot.currentAmount} KG"),
                              Text("current Price: ${lot.openingPrice} \$"),
                              Text("Predicted price: ${lot.closingPrice} \$"),
                            ],
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(color: Colors.green),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Return Date: ${lot.closingDate}"),
                              Text("Seller Rate: 4.2"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CustomBuyButton(lot),
                    ),
                  ],


                )
              ),

              Divider(),

              SizedBox(height: 20),


              // _tabSection(context),

            ]
        ),
      ),
    );
  }
}



Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.teal,
          child: TabBar(tabs: [
            Tab(text: "Last Orders"),
            Tab(text: "Seller's Info"),
            Tab(text: "Similar Lots"),
          ]),
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          child: TabBarView(children: [
            Container(
              child: Text("List of orders"),
            ),
            Container(
              child: Column(
                children: [
                  Text("name"),
                  Text("Address"),
                  Text("All Lots"),
                  Text("Contact")
                ],
              ),
            ),
            Container(
              child: Text("List of similar Lots"),
            ),
          ]),
        ),
      ],
    ),
  );
}
