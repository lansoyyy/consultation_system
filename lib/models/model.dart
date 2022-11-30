class Concern {
  String concern;
  String course;
  String dateTime;
  String email;
  String id;
  String name;
  String time;
  String yearLevel;

  Concern(
      {required this.concern,
      required this.course,
      required this.dateTime,
      required this.email,
      required this.id,
      required this.name,
      required this.time,
      required this.yearLevel});

  factory Concern.fromJson(Map<String, dynamic> json) {
    return Concern(
        concern: json['concern'],
        course: json['course'],
        dateTime: json['dateTime'].toString(),
        email: json['email'],
        id: json['id'],
        name: json['name'],
        time: json['time'],
        yearLevel: json['yearLevel']);
  }
}
