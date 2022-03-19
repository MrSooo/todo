class Task {
  int? id;
  String? title;
  String? description;
  int? isDone;
  String? date;
  String? time;
  int? reminder;
  int? color;

  Task(
      {this.id,
      this.title,
      this.description,
      this.isDone,
      this.date,
      this.time,
      this.reminder,
      this.color});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
    date = json['date'];
    time = json['time'];
    reminder = json['reminder'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isDone'] = this.isDone;
    data['date'] = this.date;
    data['time'] = this.time;
    data['reminder'] = this.reminder;
    data['color'] = this.color;
    return data;
  }
}
