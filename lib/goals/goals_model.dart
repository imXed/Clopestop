class Goal {
  int? id;
  String? title;
  String? price;

  Goal({this.id, this.title, this.price}) {
    id = this.id;
    title = this.title;
    price = this.price;
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
