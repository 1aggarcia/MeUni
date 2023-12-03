import 'i_event.dart';

class Event extends IEvent {
  //* Private Properties
  final String _title;

  //* Public Properties
  @override
  String get title => _title;

  //* Constructors
  Event({
    required super.id,
    required String title,
    required super.desc,
    required super.location,
    required super.max,
    required super.startTime,
    required super.endTime,
    required super.hostId,
    required super.hostName,
    required super.attendees,
  }) : _title = title;

  Event.fromJson(super.json)
      : _title = json['title'],
        super.fromJson();

  //* Overridden Methods
  @override
  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map['title'] = _title;

    return map;
  }
}
