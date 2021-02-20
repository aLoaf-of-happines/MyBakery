class Category {
  final String name;
  final String image;

  const Category({this.name, this.image});

  Map<String, dynamic> toMap() {
    Map deneme = {
      "name": "deneme",
      "price": 1,
    };
    return {"deneme": deneme};
  }
}

final categories = const [
  Category(name: "Ekmekler", image: "assets/images/ekmekler.jpeg"),
  Category(name: "Kahvaltılıklar", image: "assets/images/kahvaltiliklar.jpeg"),
  Category(name: "Pastalar", image: "assets/images/pastalar.jpeg"),
  Category(name: "İçecekler", image: "assets/images/icecekler.jpeg"),
  Category(name: "Tatlılar", image: "assets/images/tatlilar.jpeg"),
  Category(name: "Kurabiyeler", image: "assets/images/kurabiyeler.jpeg"),
  Category(name: "Hazır Gıdalar", image: "assets/images/hazirGidalar.jpeg"),
  Category(name: "Diğer", image: "assets/images/diger.jpeg"),
];
