import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/models/Product.dart';
import 'package:flutter_my_bakery/widgets/NewProduct.dart';
import 'package:flutter_my_bakery/services/databaseService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_my_bakery/shared/constants.dart';

class Urunler extends StatefulWidget {
  final String category;
  final List<Product> list;
  Urunler({this.category, this.list});
  @override
  _UrunlerState createState() => _UrunlerState(category, list);
}

class _UrunlerState extends State<Urunler> {
  String categoryName;
  List<Product> productList;
  TextEditingController controller = TextEditingController();

  void _addNewProduct(String prName, double prAmount) {
    final newProduct =
        Product(name: prName, amount: prAmount, category: categoryName);
    setState(() {
      DatabaseService.addProduct(newProduct);
      productList.add(newProduct);
    });
  }

  _UrunlerState(String category, List<Product> list) {
    categoryName = category;
    productList = list;
  }

  void _startAddNewProduct(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewProduct(_addNewProduct),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteProduct(String name) {
    setState(() {
      productList.removeWhere((pr) {
        if (pr.name == name) {
          DatabaseService.deleteProduct(pr);
        }
        return pr.name == name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(categoryName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              child: ListView.builder(
                itemCount: productList.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 7),
                            child: Text(
                              productList[index].name,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            child: Text(
                              productList[index].amount.toStringAsFixed(2) +
                                  " ₺",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          PopupMenuButton(
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text('Sil'),
                                        onTap: () {
                                          deleteProduct(
                                              productList[index].name);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: Text('Düzenle'),
                                        onTap: () {
                                          confirmationPopup(context, controller,
                                              productList[index].name, index);
                                        },
                                      ),
                                    )
                                  ])
                          // IconButton(
                          //     icon: Icon(Icons.edit),
                          //     onPressed: () => confirmationPopup(context,
                          //         controller, productList[index].name, index)),
                          // IconButton(
                          //     icon: Icon(Icons.delete),
                          //     onPressed: () => confirmationPopup(context,
                          //         controller, productList[index].name, index))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewProduct(context),
      ),
    );
  }

  confirmationPopup(BuildContext dialogContext,
      TextEditingController controller, String name, int index) {
    final contextW = MediaQuery.of(context).size.width;
    final sizeW = contextW / 20;

    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(
          fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: sizeW),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: "Ürünü düzenle",
        content: Column(
          children: [
            SizedBox(
              height: sizeW,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: controller
                  ..text = productList[index].amount.toString(),
                style: textStyle1,
                decoration: textInputDecoration.copyWith(
                  labelText: "Ürünün fiyatı",
                ),
                validator: (val) => val.isEmpty ? "Fiyat girin" : null,
                onChanged: (val) {}),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Düzenle",
              style: TextStyle(color: Colors.white, fontSize: sizeW),
            ),
            onPressed: () {
              if (controller.value.text != "") {
                Product newProduct = Product(
                    name: name,
                    category: widget.category,
                    amount: double.parse(controller.value.text));
                setState(() {
                  productList[index] = newProduct;
                  Navigator.pop(context);
                });
                DatabaseService.updateProduct(name, newProduct);
              }
            },
            color: Colors.blue,
          )
        ]).show();
  }
}
