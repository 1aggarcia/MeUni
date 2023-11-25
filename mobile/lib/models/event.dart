import 'i_event.dart';

class Event extends IEvent {
  //* Public Properties
  final String title;

  //* Constructors
  Event({
    required super.id,
    required this.title,
    required super.desc,
    required super.location,
    required super.max,
    required super.startTime,
    required super.endTime,
    required super.hostId,
    required super.hostName,
    required super.attendees,
  });

  Event.fromJson(super.json)
      : title = json['title'],
        super.fromJson();

  //* Overridden Methods
  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map['title'] = title;

    return map;
  }
}
