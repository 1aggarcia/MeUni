import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'events_viewmodel.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EventsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: viewModel.events.isEmpty
            ? MaterialButton(
                color: Colors.black,
                onPressed: () async => await viewModel.getEventsAsync(),
                child: const Text(
                  'Get Events',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: viewModel.events.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(viewModel.events[index].title));
                }),
      ),
    );
  }

  @override
  EventsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventsViewModel();
}
