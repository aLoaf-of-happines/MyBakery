import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DatabaseService {

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  static final DateFormat formatter2 = DateFormat.Hms();
  static var uuid = Uuid();
  static final employeesReference =
      FirebaseDatabase.instance.reference().child("bakeries").child('bakery').child('employees');

  static final dailyDataReference =
      FirebaseDatabase.instance.reference().child("bakeries").child('bakery').child('dailyData');
  static final marketsReference =
      FirebaseDatabase.instance.reference().child("bakeries").child('bakery').child('markets');

  static final veresiyelerDataReference = FirebaseDatabase.instance
      .reference()
      .child("bakeries")
      .child('bakery')
      .child('veresiyeler');

  static void addEmployee(Map data) {
    var v1 = uuid.v1();
    employeesReference.child(v1).set(data);
  }

  static void addEkmek(String uid, Map data) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("producedBreads").child(uid).set(data);
  }

  static void addExpense(String uid, Map data) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("expenses").child(uid).set(data);
  }

  static void addNote(String uid, Map data) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("notes").child(uid).set(data);
  }

  static void addVeresiye(String title, Map data) {
    veresiyelerDataReference.child(title).set(data);
  }

  static void addTx(Map data) {
    var day = formatter.format(DateTime.now());
    var time = formatter2.format(DateTime.now());
    dailyDataReference.child(day).child("tx").child(time).set(data);
  }

  static void updateEmployee(String uid, Map data) {
    employeesReference.child(uid).update(data);
  }

  static void updateExpense(String uid, Map data) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("expenses").child(uid).update(data);
  }

  static void updateNote(String uid, Map data) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("notes").child(uid).update(data);
  }

  static void updateVeresiye(String title, Map data) {
    veresiyelerDataReference.child(title).update(data);
  }

  static void deleteEmployee(String uid) {
    employeesReference.child(uid).remove();
  }

 static void deleteEkmek(String uid) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("producedBreads").child(uid).remove();
  }

 static void deleteExpense(String uid) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("expenses").child(uid).remove();
  }

 static void deleteNote(String uid) {
    var day = formatter.format(DateTime.now());
    dailyDataReference.child(day).child("notes").child(uid).remove();
  }

 static void deleteVeresiye(String title) {
    veresiyelerDataReference.child(title).remove();
  }
}
