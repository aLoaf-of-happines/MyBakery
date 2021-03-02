import 'package:firebase_auth/firebase_auth.dart';
import 'databaseService.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class AuthService {

  static final String username = 'aloafofhappiness@gmail.com';
  static final String password = 'Aloafofhappiness+';
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email&password
  static Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // register with email&password
  static Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var x = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      x.user.uid;
      return x.user.uid;
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // sign out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  @deprecated
  static void registerWorkers() {
    DatabaseService.workersReference.once().then((DataSnapshot snapshot) {
      final smtpServer = gmail(username, password);
      Map map = snapshot.value;
      map.forEach((key, value) async {
        var check = await registerWithEmailAndPassword(
            value['mail'], value['passwd']);

        if (check != null) {
          await Firestore.instance
              .collection('users')
              .document(check)
              .setData({'userid': check, 'role': value['job']});
        }

        if (check != null) {
          final message = Message()
            ..from = Address(username, 'a Loaf of Happiness')
            ..recipients.add(value['mail'])
            ..subject = 'Login'
            ..html = "<p>My Bakery giriş şifreniz: ${value['passwd']}</p>";

          try {
            await send(message, smtpServer);
            //print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            //print('Message not sent.');
            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }
        }
      });
    });
  }
}
