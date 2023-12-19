class AppSlider {
  String? id;
  String? image;

  AppSlider({this.id, this.image});

  AppSlider.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
  }
}
