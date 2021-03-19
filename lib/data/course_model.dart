
class Course {
  int id;
  String image;
  String title;
  String description;

  Course({this.id, this.image, this.title, this.description});

  factory Course.fromJson(Map<String,dynamic> json){
    Course c = Course();
    c.id = json['id'];
    c.title = json['title'];
    c.description = json['description'];
    c.image = json['image'];
    return c;
  }

}