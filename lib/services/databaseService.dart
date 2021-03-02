
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_my_bakery/models/Category.dart';
import 'package:flutter_my_bakery/models/Market.dart';
import 'package:flutter_my_bakery/models/Payer.dart';
import 'package:flutter_my_bakery/models/Product.dart';
import 'package:flutter_my_bakery/models/Worker.dart';

class DatabaseService {
  static var bakeryRef =
      FirebaseDatabase.instance.reference().child('bakeries').child('bakery');
  static var marketsReference = FirebaseDatabase.instance
      .reference()
      .child('bakeries')
      .child('bakery')
      .child('markets');
  static var workersReference = FirebaseDatabase.instance
      .reference()
      .child('bakeries')
      .child('bakery')
      .child('employees');
  static var payersReference = FirebaseDatabase.instance
      .reference()
      .child('bakeries')
      .child('bakery')
      .child('veresiyeler');
  static var categoryReference = FirebaseDatabase.instance
      .reference()
      .child('bakeries')
      .child('bakery')
      .child('categories');
  static var bakeryReference =
      FirebaseDatabase.instance.reference().child("bakeries");
  static var dailyDataReference = FirebaseDatabase.instance
      .reference()
      .child('bakeries')
      .child('bakery')
      .child('dailyData');

  static void addMarket(Market market) async {
    DataSnapshot snap = await FirebaseDatabase.instance
        .reference()
        .child('bakeries')
        .child('bakery')
        .once();
    var borc =
        snap.value['debt'] != null ? double.parse(snap.value['debt']) : 0.0;

    borc = borc + market.debt;
    FirebaseDatabase.instance
        .reference()
        .child('bakeries')
        .child('bakery')
        .update({"debt": borc.toString()});

    marketsReference.child(market.name).set(market.toMap());
  }

  static void deleteMarket(String marketName) {
    marketsReference.child(marketName).remove();
  }

  static void addWorker(Worker worker) {
    workersReference.child(worker.name).set(worker.toMap());
  }

  

  static void deleteWorker(String workerName) {
    workersReference.child(workerName).remove();
  }

  static void updateWorker(String workerName, Worker worker) {
    workersReference.child(workerName).update(worker.toMap());
  }

  static void addPayer(Payer payer) {
    payersReference.child(payer.name).set(payer.toMap());
  }

  static void addCategory(Category category) {
    categoryReference.child(category.name).set(category.toMap());
  }

  static void deletePayer(String payerName) {
    payersReference.child(payerName).remove();
  }

  static void deleteProduct(Product product) {
    categoryReference.child(product.category).child(product.name).remove();
  }

  static void deleteProduct2(String categoryName, String productName) {
    categoryReference.child(categoryName).child(productName).remove();
  }

  static void deleteCategory(String categoryName) {
    categoryReference.child(categoryName).remove();
  }

  static void updateCategory(String categoryName, Category category) {
    workersReference.child(categoryName).update(category.toMap());
  }

  static void addProduct(Product product) {
    categoryReference
        .child(product.category)
        .child(product.name)
        .set(product.toMap());
  }

  static void updateProduct(String uid, Product product) {
    categoryReference
        .child(product.category)
        .child(uid)
        .update(product.toMap());
  }
}
