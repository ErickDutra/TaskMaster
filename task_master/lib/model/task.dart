class Task {
  String title;
  TaskPriority priority;
  RepatedMode repeatedMode;
  DateTime? dateTask;
  bool notification;
  bool completed;
  DateTime? hoursNotify;
  Task({
    required this.title,
    this.priority = TaskPriority.medium,
    this.repeatedMode = RepatedMode.focusTotal,
    this.dateTask,
    this.notification = false,
    this.completed = false,
    this.hoursNotify,
  });
}

enum TaskPriority { low, medium, high }

enum RepatedMode {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  focusTotal,
}
