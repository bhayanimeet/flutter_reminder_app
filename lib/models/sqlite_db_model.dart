class Task {
  int? id;
  final String title;
  final String task;
  final String date;
  final String startTime;
  final String endTime;
  final String reminder;
  final int isSelected;

  Task({
    this.id,
    required this.title,
    required this.task,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.isSelected,
  });

  factory Task.fromMap({required Map<String,dynamic> data}){
    return Task(
      id: data['id'],
      title: data['title'],
      task: data['task'],
      date: data['date'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      reminder: data['reminder'],
      isSelected: data['isSelected'],
    );
  }
}
