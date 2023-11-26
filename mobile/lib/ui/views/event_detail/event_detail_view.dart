import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event.dart';
import '../../widgets/i_event/i_event_detail_view/i_event_detail_view.dart';
import 'event_detail_viewmodel.dart';

class EventDetailView extends StackedView<EventDetailViewModel> {
  //* Private Properties
  final String eventId;

  //* Constructors
  const EventDetailView({
    super.key,
    required this.eventId,
  });

  //* Overridden Methods
  @override
  EventDetailViewModel viewModelBuilder(BuildContext context) =>
      EventDetailViewModel();

  @override
  Widget builder(
      BuildContext context, EventDetailViewModel viewModel, Widget? child) {
    return IEventDetailView<Event>(iEventId: eventId);
  }
}
