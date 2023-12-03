abstract class IEvent {
  //* Public Properties
  final String id;

  final String desc;
  final String location;

  final int max;

  final DateTime startTime;
  final DateTime endTime;

  final String hostId;
  final String hostName;
  final List<String> attendees;

  String get title;

  //* Constructors
  IEvent({
    required this.id,
    required this.desc,
    required this.location,
    required this.max,
    required this.startTime,
    required this.endTime,
    required this.hostId,
    required this.hostName,
    required this.attendees,
  });

  IEvent.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        desc = json['desc'],
        location = json['location'],
        max = json['max'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        hostId = json['hostId'],
        hostName = json['hostName'],
        attendees = json.containsKey('attendees')
            ? List<String>.from(json['attendees'])
            : [];

  //* Public Methods
  Map<String, dynamic> toJson() => {
        'id': id,
        'desc': desc,
        'location': location,
        'max': max,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'hostId': hostId,
        'hostName': hostName,
        'attendees': attendees,
      };
}
