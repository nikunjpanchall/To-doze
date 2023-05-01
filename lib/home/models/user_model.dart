class UserModel {
  String? email;
  String? name;
  String? userId;

  UserModel({this.email, this.name, this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['userId'] = this.userId;
    return data;
  }
}
