class Goal {
  int? id;
  String? title;
  String? price;

  Goal({this.id, this.title, this.price}) {
    id = id;
    title = title;
    price = price;
  }

  toJson() {
    return {"id": id, "price": price, "title": title};
  }

  fromJson(jsonData) {
    return Goal(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
    );
  }
}
