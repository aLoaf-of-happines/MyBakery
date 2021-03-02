import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/screens/setup/urunler.dart';
import '../models/Product.dart';

class CategoryItem extends StatefulWidget {
  final String name;
  final String image;

  CategoryItem(this.name, this.image);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  List<Product> liste = [];
  void goProduct(BuildContext cx) async {

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
