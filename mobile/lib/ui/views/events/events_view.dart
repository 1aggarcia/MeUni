import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/event_card.dart';
import 'events_viewmodel.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        body: viewModel.isLoading
            ? const Text('Loading...')
            : Container(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  children: [
                    Text('Hi! ${viewModel.userName}'),
                    verticalSpaceLarge,
                    Row(
                      children: [
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async => await viewModel.logoutAsync(),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async =>
                              await viewModel.getEventsAsync(),
                          child: const Text(
                            'Get Events',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async =>
                              await viewModel.goToCreateEventPageAsync(),
                          child: const Text(
                            'Add Event',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    for (var event in viewModel.events) ...[
                      EventCard(event: event)
                    ]
                  ],
                )),
      ),
    );
  }

  @override
  EventsViewModel viewModelBuilder(BuildContext context) => EventsViewModel();
}
