class Item {
  int id;
  int storeId;
  int categoryId;
  String name;
  String description;
  double price;
  int status;
  String condition;
  String image;
  int active;
  String createdAt;
  String updatedAt;
  Category category;

  Item(
      {this.id,
      this.storeId,
      this.categoryId,
      this.name,
      this.description,
      this.price,
      this.status,
      this.condition,
      this.image,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.category});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'].toDouble();
    status = json['status'];
    condition = json['condition'];
    image = json['image'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['condition'] = this.condition;
    data['image'] = this.image;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  Null createdAt;
  Null updatedAt;

  Category({this.id, this.name, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
