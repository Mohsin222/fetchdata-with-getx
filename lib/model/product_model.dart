class ProductModel {
  String? name;
  String? description;
  String? richDescription;
  String? image;
  List<String>? images;
  String? brand;
  int? price;
  String? category;
  int? countInStock;
  int? rating;
  int? numReviews;
  bool? isFeatured;
  String? sId;
  String? dateCreated;
  int? iV;

  ProductModel(
      {this.name,
      this.description,
      this.richDescription,
      this.image,
      this.images,
      this.brand,
      this.price,
      this.category,
      this.countInStock,
      this.rating,
      this.numReviews,
      this.isFeatured,
      this.sId,
      this.dateCreated,
      this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name']  ?? '';
    description = json['description']  ?? '';
    richDescription = json['richDescription']  ?? '';
    image = json['image']  ?? '';
    images = json['images'].cast<String>()  ?? [];
    brand = json['brand']  ?? '';
    price = json['price']  ?? '';
    category = json['category']  ?? '';
    countInStock = json['countInStock']  ?? 0;
    rating = json['rating']  ?? 0;
    numReviews = json['numReviews'] ?? '';
    isFeatured = json['isFeatured'] ?? '';
    sId = json['_id'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    iV = json['__v'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['richDescription'] = this.richDescription;
    data['image'] = this.image;
    data['images'] = this.images;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['category'] = this.category;
    data['countInStock'] = this.countInStock;
    data['rating'] = this.rating;
    data['numReviews'] = this.numReviews;
    data['isFeatured'] = this.isFeatured;
    data['_id'] = this.sId;
    data['dateCreated'] = this.dateCreated;
    data['__v'] = this.iV;
    return data;
  }
}
