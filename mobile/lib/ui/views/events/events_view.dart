import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event.dart';
import '../../widgets/i_event/i_events_view/i_events_view.dart';
import 'events_viewmodel.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({super.key});

  //* Overridden Methods
  @override
  EventsViewModel viewModelBuilder(BuildContext context) => EventsViewModel();

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return IEventsView<Event>();
  }
}
