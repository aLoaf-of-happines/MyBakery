import 'dart:ui';

import 'package:flutter/material.dart';

import 'categories.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void nextPage(BuildContext cx) {
    Navigator.of(cx).push(
      MaterialPageRoute(
        builder: (_) {
          return Categories();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/setupbg.jpeg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: Colors.white70,
                    child: ListTile(
                      title: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 5),
                        child: Text(
                          "HOŞGELDİNİZ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        "Alttaki butonuna tıklayarak fırınınızı oluşturmaya başlayabilirsiniz.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          wordSpacing: 0.75,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(0.6, 0),
                  child: RaisedButton(
                    onPressed: () => nextPage(context),
                    child: Text("BAŞLAYALIM"),
                    color: Colors.blueGrey,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ],
      ),
    );
  }
}
