class UserModel {
  String? email;
  String? name;
  String? userId;
  String? profiledPhoto;

  UserModel({this.email, this.name, this.userId, this.profiledPhoto});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    userId = json['userId'];
    profiledPhoto = json['profiledPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['profiledPhoto'] = this.profiledPhoto;
    return data;
  }
}
