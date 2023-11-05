import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/event_card.dart';
import '../../widgets/round_button.dart';
import 'events_viewmodel.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: viewModel.isLoading
          ? const Text('Loading...')
          : Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const RoundButton(
                        label: 'Logout',
                      ),
                      MaterialButton(
                        color: Colors.black,
                        onPressed: () async => await viewModel.getEventsAsync(),
                        child: const Text(
                          'Get Events',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.black,
                        onPressed: () async => await viewModel.getEventsAsync(),
                        child: const Text(
                          'Add Event',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  for (var event in viewModel.events) EventCard(event: event)
                ],
              )),
    );
  }

  @override
  EventsViewModel viewModelBuilder(BuildContext context) => EventsViewModel();
}
