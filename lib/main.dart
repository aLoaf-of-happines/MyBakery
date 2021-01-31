import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/screens/authenticate/sign_in.dart';
import 'package:flutter_my_bakery/screens/home/bottom_bar_state.dart';
import 'package:flutter_my_bakery/screens/service/service_main.dart';
import 'package:flutter_my_bakery/screens/setup/firstPage.dart';
import 'package:flutter_my_bakery/screens/tezgahtar/tezgahtar.dart';
import 'package:flutter_my_bakery/services/databaseService.dart';
import 'package:flutter_my_bakery/shared/loading.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    service.bakeryReference.onValue.listen((event){
      Map value = event.snapshot.value;
      bakery = value;
      //print(value);
    });


    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          ////print(length);
          if (snapshot.hasData && snapshot.data != null) {
            Firestore.instance
                .collection('users')
                .document(snapshot.data.uid)
                .get()
                .then((DocumentSnapshot snapshot2) {
              Map x = snapshot2.data();
              ////print(x);

              setState(() {
                role = x["role"];
              });
            });

            if(role == "Yönetici" ||
                role == "Yonetici" ||
                role == "yönetici" ||
                role == "yonetici"){
              if(bakery == null){
                return FirstPage();
              } else if(bakery != null){
                return BottomBarState();
              } else{
                return Loading();
              }
            } else if (role == "Tezgahtar" || role == "tezgahtar") {
              if(bakery == null){
                return FirstPage();
              } else if(bakery != null){
                return Tezgahtar();
              } else{
                return Loading();
              }
            } else if(role == "Şoför" ||
                role == "Soför" ||
                role == "Şofor" ||
                role == "Sofor"){
              if(bakery == null){
                return FirstPage();
              } else if(bakery != null){
                return Service();
              } else{
                return Loading();
              }
            }
          }
          return SignIn();
        });
  }

  String getRole(String docID) {
    Firestore.instance
        .collection('users')
        .document(docID)
        .get()
        .then((DocumentSnapshot snapshot) {
      Map x = snapshot.data();
      //print(x["role"]);

      return x["role"];
    });
  }
}
