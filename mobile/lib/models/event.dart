class Event {
  //* Public Properties
  final int id;

  final String title;
  final String desc;
  final String location;

  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final int hostId;
  final String hostName;
  final List<int> attendees;

  //* Constructors
  Event({
    required this.id,
    required this.title,
    required this.desc,
    required this.location,
    required this.max,
    required this.startTime,
    required this.endTime,
    required this.hostId,
    required this.hostName,
    required this.attendees,
  });
}
