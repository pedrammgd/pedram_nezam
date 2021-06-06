class TagsProduct {
  TagsProduct({
    this.id,
    this.tagName,
  });

  int id;
  String tagName;
  String toString() {
    return '{$id,$tagName}';
  }
  factory TagsProduct.fromJson(Map<String, dynamic> json) => TagsProduct(
    id: json["id"],
    tagName: json["tagName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tagName": tagName,
  };
}