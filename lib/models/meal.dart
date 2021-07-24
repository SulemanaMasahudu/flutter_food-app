class Meal {
  int mealId;
  String mealDescription;
  String mealName;
  String mealPhoto;
  int mealPrice;

  Meal({this.mealDescription, this.mealName, this.mealPhoto, this.mealPrice});

  Meal.fromJson(Map<String, dynamic> json) {
    mealId = json['meal_id'];
    mealDescription = json['meal_description'];
    mealName = json['meal_name'];
    mealPhoto = json['meal_photo'];
    mealPrice = json['meal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_id'] = this.mealId;
    data['meal_description'] = this.mealDescription;
    data['meal_name'] = this.mealName;
    data['meal_photo'] = this.mealPhoto;
    data['meal_price'] = this.mealPrice;
    return data;
  }
}
