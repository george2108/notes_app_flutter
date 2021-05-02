class NoteModel {
  int id;
  String title;
  String body;
  DateTime createdAt;

  NoteModel({this.id, this.title, this.body, this.createdAt});

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "body": this.body,
      "createdAt": this.createdAt.toString(),
    });
  }
}
