import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import 'event_detail_viewmodel.dart';

class EventDetailView extends StackedView<EventDetailViewModel> {
  //* Private Properties
  final String eventId;

  const EventDetailView({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventDetailViewModel viewModel, Widget? child) {
    const labelTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );

    const infoTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: viewModel.isBusy ? const LoadingIndicator(loadingText: 'Creating Event')
          :SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  // Title
                  const Text(
                    'Title',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.event!.title,
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Description
                  const Text(
                    'Description',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.event!.desc,
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Location
                  const Text(
                    'Location',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.event!.location,
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Date
                  const Text(
                    'Date',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    DateFormat.MMMEd().format(viewModel.event!.startTime),
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Start Time
                  const Text(
                    'Start Time',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    DateFormat.jm().format(viewModel.event!.startTime),
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // End Time
                  const Text(
                    'End Time',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    DateFormat.jm().format(viewModel.event!.endTime),
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Host
                  const Text(
                    'Host',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.event!.hostName,
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  // Attendees
                  const Text(
                    'Attendees',
                    style: labelTextStyle,
                  ),
                  verticalSpaceSmall,
                  Text(
                    viewModel.event!.attendees.toString(),
                    style: infoTextStyle,
                  ),
                  verticalSpaceMedium,

                  MaterialButton(
                    color: Colors.black,
                    onPressed: () async => await viewModel.joinEvent(),
                    child: const Text(
                      'Join Event',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  EventDetailViewModel viewModelBuilder(BuildContext context) {
    EventDetailViewModel model = EventDetailViewModel(eventId);
    unawaited(model.getEvents());
    return model;
  }
}

