class CurtItems {
  String dateCreated;
  int mealId;
  String mealName;
  String mealPhoto;
  int mealPrice;
  int mealQuantity;
  int userId;

  CurtItems(
      {this.dateCreated,
        this.mealId,
        this.mealName,
        this.mealPhoto,
        this.mealPrice,
        this.mealQuantity,
        this.userId});

  CurtItems.fromJson(Map<String, dynamic> json) {
    dateCreated = json['date_created'];
    mealId = json['meal_id'];
    mealName = json['meal_name'];
    mealPhoto = json['meal_photo'];
    mealPrice = json['meal_price'];
    mealQuantity = json['meal_quantity'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    data['meal_id'] = this.mealId;
    data['meal_name'] = this.mealName;
    data['meal_photo'] = this.mealPhoto;
    data['meal_price'] = this.mealPrice;
    data['meal_quantity'] = this.mealQuantity;
    data['user_id'] = this.userId;
    return data;
  }
}
