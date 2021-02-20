import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/models/Product.dart';
import 'package:flutter_my_bakery/screens/setup/urunler.dart';
import 'package:flutter_my_bakery/services/databaseService.dart';

class ProductItem extends StatefulWidget {
  final String name;
  final String image;

  ProductItem(this.name, this.image);

  @override
  ProductItemState createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  DatabaseService service = DatabaseService('bakery');
  void goProduct(BuildContext cx) async {
    List<Product> liste = [];
    await service.categoryReference
        .child(widget.name)
        .once()
        .then((DataSnapshot snapshot) {
      Map map = snapshot.value;
      if (map != null) {
        map.forEach((key, value) {
          bool isEqual = false;
          liste.forEach((element) {
            if (element.name == value['name']) {
              isEqual = true;
            }
          });

          if (isEqual == false) {
            liste.add(Product(
                name: value['name'],
                amount: value['price'].toDouble(),
                category: widget.name));
          }
        });
      }
    });

    Navigator.of(cx).push(
      MaterialPageRoute(
        builder: (_) {
          return Urunler(category: widget.name, list: liste);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goProduct(context),
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 14),
                child: Image.asset(
                  widget.image,
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
