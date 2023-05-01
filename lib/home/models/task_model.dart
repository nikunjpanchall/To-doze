class TaskModel {
  bool? isCompleted;
  String? todo;
  String? userId;

  TaskModel({this.isCompleted, this.todo, this.userId});

  TaskModel.fromJson(Map<String, dynamic> json) {
    isCompleted = json['isCompleted'];
    todo = json['todo'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCompleted'] = this.isCompleted;
    data['todo'] = this.todo;
    data['userId'] = this.userId;
    return data;
  }
}
