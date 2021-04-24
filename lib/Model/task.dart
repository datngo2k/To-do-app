class Task {
  String title;
  bool isDone;
  int id;
  Task({this.title, this.isDone, this.id});
  void toggle() {
    isDone = !isDone;
  }
}
