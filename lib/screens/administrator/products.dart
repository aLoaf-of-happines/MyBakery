import 'package:flutter/material.dart';
import 'package:flutter_my_bakery/models/Category.dart';
import 'package:flutter_my_bakery/screens/administrator/product_item.dart';

String uid;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   return StreamBuilder<Event>(
    //     stream: service.categoryReference.onValue,
    //     builder: (context, snapshot) {
    //       Map data = {};
    //       List item = [];
    //       if (snapshot.hasData) {
    //         data = snapshot.data.snapshot.value;
    //         if (data == null) {
    //           return Scaffold(
    //             appBar: AppBar(
    //               title: Text(
    //                 "Ürünler",
    //                 style: TextStyle(fontFamily: "Poppins"),
    //               ),
    //               centerTitle: true,
    //               backgroundColor: Colors.blueGrey,
    //             ),
    //             floatingActionButton: FloatingActionButton(
    //               onPressed: () {
    //                 confirmationPopup(context, image, 0, 0, "", controller);
    //               },
    //               child: Icon(Icons.add),
    //             ),
    //           );
    //         }
    //         data.forEach((index, data) => item.add({"key": index, ...data}));
    //       }

    //       if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return Container(
    //             height: 200.0,
    //             alignment: Alignment.center,
    //             child: CircularProgressIndicator(
    //               valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
    //             ),
    //           );
    //         default:
    //           return Scaffold(
    //             appBar: AppBar(
    //               title: Text(
    //                 "Ürünler",
    //                 style: TextStyle(fontFamily: "Poppins"),
    //               ),
    //               centerTitle: true,
    //               backgroundColor: Colors.blueGrey,
    //             ),
    //             body: ListView.builder(
    //               itemCount: item.length,
    //               itemBuilder: (context, index) {
    //                 return ListTile(
    //                   onLongPress: () {
    //                     controller.text = item[index]["name"];
    //                     uid = item[index]["name"];
    //                     confirmationPopup(
    //                         context, image, 1, index, "", controller);
    //                   },
    //                   onTap: () {
    //                     try {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) =>
    //                                 ProductsIn(category: item[index]["key"])),
    //                       );
    //                     } on Exception catch (_) {
    //                       //print("asd");
    //                     }
    //                   },
    //                   leading: ConstrainedBox(
    //                     constraints: BoxConstraints(
    //                       minWidth: sizeW,
    //                       minHeight: sizeH,
    //                       maxWidth: sizeW + 20,
    //                       maxHeight: sizeH + 20,
    //                     ),
    //                     child: Icon(Icons.category),
    //                   ),
    //                   title: Text(
    //                     item[index]["key"],
    //                     style: TextStyle(fontFamily: "Poppins"),
    //                   ),
    //                 );
    //               },
    //             ),
    //             floatingActionButton: FloatingActionButton(
    //               onPressed: () {
    //                 confirmationPopup(context, image, 0, 0, "", controller);
    //               },
    //               child: Icon(Icons.add),
    //             ),
    //           );
    //       }
    //     },
    //   );
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text("Kategoriler"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.4),
            children: categories
                .map((catData) => ProductItem(catData.name, catData.image))
                .toList(),
          ),
        ));
  }

  // confirmationPopup(BuildContext dialogContext, Widget image, int val,
  //     int index, String categoryName, TextEditingController controller) {
  //   final contextW = MediaQuery.of(context).size.width;
  //   final sizeW = contextW / 20;

  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.grow,
  //     overlayColor: Colors.black87,
  //     isOverlayTapDismiss: true,
  //     titleStyle: TextStyle(
  //         fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: sizeW),
  //     animationDuration: Duration(milliseconds: 400),
  //   );

  //   Alert(
  //       context: dialogContext,
  //       style: alertStyle,
  //       title: val == 0 ? "Kategori ekle" : "Kategoriyi düzenle",
  //       content: Column(
  //         children: [
  //           SizedBox(
  //             height: sizeW,
  //           ),
  //           ConstrainedBox(
  //             constraints: BoxConstraints(
  //               minWidth: 50,
  //               minHeight: 100,
  //               maxWidth: 100,
  //               maxHeight: 150,
  //             ),
  //             child: Icon(
  //               Icons.category,
  //               size: 70,
  //             ),
  //           ),
  //           SizedBox(
  //             height: sizeW,
  //           ),
  //           TextFormField(
  //             controller: controller,
  //             style: textStyle1,
  //             decoration: textInputDecoration.copyWith(
  //               labelText: "Kategorinin ismi",
  //             ),
  //             validator: (val) => val.isEmpty ? "Enter an email" : null,
  //             onChanged: (val) {
  //               setState(() {});
  //             },
  //           ),
  //         ],
  //       ),
  //       buttons: [
  //         val == 1
  //             ? DialogButton(
  //                 child: Text(
  //                   "Sil",
  //                   style: TextStyle(color: Colors.white, fontSize: sizeW),
  //                 ),
  //                 onPressed: () {
  //                   setState(() {
  //                     service.deleteCategory(uid);
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 color: Colors.red,
  //               )
  //             : DialogButton(
  //                 child: Text(
  //                   "İptal",
  //                   style: TextStyle(color: Colors.white, fontSize: sizeW),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 color: Colors.red,
  //               ),
  //         DialogButton(
  //           child: Text(
  //             val == 0 ? "Ekle" : "Düzenle",
  //             style: TextStyle(color: Colors.white, fontSize: sizeW),
  //           ),
  //           onPressed: () {
  //             if (controller.value.text != "") {
  //               final newCategory = Category(name: controller.value.text);
  //               setState(() {
  //                 if (val == 0) {
  //                   service.addCategory(newCategory);
  //                 } else {
  //                   service.updateCategory(uid, newCategory);
  //                 }
  //               });
  //             }
  //             Navigator.pop(context);
  //           },
  //           color: Colors.blue,
  //         )
  //       ]).show();
  // }
}
