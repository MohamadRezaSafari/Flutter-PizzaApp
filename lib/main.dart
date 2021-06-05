import 'package:flutter/material.dart';
import 'dart:ui';
//import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pizza_app/models/pizza.dart';
import 'details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza App',
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'salbo'),
      home: PizzaHome(),
    );
  }
}

class PizzaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Color(0xff000000));
    return Scaffold(
      body: MainApp(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 50, right: 30),
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[titleBar(), tabs()],
            ),
          )
        ],
      ),
    );
  }
}

Widget titleBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Text(
            "Featured",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
          ),
          Text(
            "Food",
            style: TextStyle(fontSize: 50),
          )
        ],
      )
    ],
  );
}

Widget tabs() {
  return Container(
    height: 580,
    width: double.infinity,
    child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(top: 15),
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: "slabo"),
                      unselectedLabelColor: Colors.black26,
                      unselectedLabelStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                          fontFamily: "slabo"),
                      tabs: <Widget>[
                        Container(
                          child: Text("Pizza"),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: Text("Rolles"),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: Text("Burgers"),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: Text("Sandwiches"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              pizzaShowCase(),
              Center(
                child: Text(
                  "Rolles Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Burgers Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Sandwiches Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
        )),
  );
}

Widget pizzaShowCase() {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pizzaList.pizzas.length,
        itemBuilder: (BuildContext context, int i) {
          return ListOfPizzas(
            name: pizzaList.pizzas[i].name,
            image: pizzaList.pizzas[i].image,
            background: pizzaList.pizzas[i].background,
            foreground: pizzaList.pizzas[i].foreground,
            pizzaObject: pizzaList.pizzas[i],
            price: pizzaList.pizzas[i].price,
          );
        },
      ));
}

class ListOfPizzas extends StatelessWidget {
  final Color foreground;
  final Color background;
  final double price;
  final String name;
  final String image;
  final Pizza pizzaObject;

  const ListOfPizzas(
      {required this.foreground,
      required this.background,
      required this.price,
      required this.name,
      required this.image,
      required this.pizzaObject});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Details(pizzaObject)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
            width: 225,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: Image.asset(image),
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  softWrap: true,
                  text: TextSpan(
                    style: TextStyle(
                        color: foreground, fontSize: 25, fontFamily: "slabo"),
                    children: [
                      TextSpan(text: name),
                      TextSpan(
                          text: "\nPizza",
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                //SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "\n \$$price",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: foreground,
                            fontFamily: "arial"),
                      ),
                    ),
                    // Icon(
                    //   Icons.favorite,
                    //   color: Colors.pinkAccent,
                    //   size: 20.0,
                    //   semanticLabel: 'Text to announce in accessibility modes',
                    // ),
                    StatefulFavIcon(foreground: foreground),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 40,
        )
      ],
    );
  }
}

class StatefulFavIcon extends StatefulWidget {
  const StatefulFavIcon({required this.foreground});

  final Color foreground;

  @override
  _StatefulFavIconState createState() => _StatefulFavIconState();
}

class _StatefulFavIconState extends State<StatefulFavIcon> {
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: widget.foreground,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final double _size = 60;
  final double _padding = 17;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://avatars.githubusercontent.com/u/21293464?v=4",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/home_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/search_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/bag_icon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
