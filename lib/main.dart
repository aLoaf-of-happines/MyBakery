import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/authenticate/sign_in.dart';
import 'screens/home/bottom_bar_state.dart';
import 'screens/service/service_main.dart';
import 'screens/setup/firstPage.dart';
import 'screens/tezgahtar/tezgahtar.dart';
import 'services/databaseService.dart';

String role;
Map bakery;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Bakery",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DatabaseService service = DatabaseService('bakery');

  @override
  Widget build(BuildContext context) {
    service.bakeryReference.onValue.listen((event) {
      Map value = event.snapshot.value;
      setState(() {
        bakery = value;
      });
      //print(value);
    });

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // ignore: deprecated_member_use
            Firestore.instance
                .collection('users')
                // ignore: deprecated_member_use
                .document(snapshot.data.uid)
                .get()
                .then((DocumentSnapshot snapshot2) {
              Map x = snapshot2.data();
              ////print(x);

              setState(() {
                role = x["role"];
              });
            });

            //print(bakery);

            if (role == "Yönetici" ||
                role == "Yonetici" ||
                role == "yönetici" ||
                role == "yonetici") {
              if (bakery == null) {
                return FirstPage();
              } else if (bakery != null) {
                return BottomBarState();
              }
            } else if (role == "Tezgahtar" || role == "tezgahtar") {
              if (bakery == null) {
                return FirstPage();
              } else if (bakery != null) {
                return Tezgahtar();
              }
            } else if (role == "Şoför" ||
                role == "Soför" ||
                role == "Şofor" ||
                role == "Sofor") {
              if (bakery == null) {
                return FirstPage();
              } else if (bakery != null) {
                return Service();
              }
            }
          }
          return SignIn();
        });
  }

  // ignore: missing_return
  String getRole(String docID) {
    // ignore: deprecated_member_use
    Firestore.instance
        .collection('users')
        // ignore: deprecated_member_use
        .document(docID)
        .get()
        .then((DocumentSnapshot snapshot) {
      Map x = snapshot.data();
      //print(x["role"]);

      return x["role"];
    });
  }
}
