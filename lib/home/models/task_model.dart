class TaskModel {
  String? id;
  bool? isCompleted;
  String? todo;
  String? userId;

  TaskModel({this.id, this.isCompleted, this.todo, this.userId});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCompleted = json['isCompleted'];
    todo = json['todo'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isCompleted'] = this.isCompleted;
    data['todo'] = this.todo;
    data['userId'] = this.userId;
    return data;
  }
}
