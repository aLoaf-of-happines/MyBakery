import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/screens/authenticate/sign_in.dart';
import 'package:flutter_my_bakery/screens/home/home.dart';
import 'package:flutter_my_bakery/services/auth.dart';
import 'package:flutter_my_bakery/shared/loading.dart';

class BottomBarState extends StatefulWidget {
  @override
  _BottomBarStateState createState() => _BottomBarStateState();
}

class _BottomBarStateState extends State<BottomBarState> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "İslam Unlu Mamülleri",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              backgroundColor: Colors.blueGrey,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Çıkış",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                  ),
                  onPressed: () async {
                    setState(() => loading = true);
                    dynamic result = await AuthService.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (route) => false);
                    if (result == null) {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                )
              ],
            ),
            body: Home(),
          );
  }
}
