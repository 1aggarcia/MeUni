import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/round_button.dart';
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
      EventDetailViewModel(eventId);

  @override
  void onViewModelReady(EventDetailViewModel viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) async => await viewModel.getEventAsync());

  @override
  Widget builder(
      BuildContext context, EventDetailViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Detail'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? const LoadingIndicator(loadingText: 'Loading Event Details')
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      // Title
                      _fieldLabel(
                        label: 'Title',
                        value: viewModel.event.title,
                      ),

                      verticalSpaceMedium,

                      // Description
                      _fieldLabel(
                        label: 'Description',
                        value: viewModel.event.desc,
                      ),

                      verticalSpaceMedium,

                      // Location
                      _fieldLabel(
                        label: 'Location',
                        value: viewModel.event.location,
                      ),

                      verticalSpaceMedium,

                      // Date
                      _fieldLabel(
                        label: 'Date',
                        value: DateFormat.MMMEd()
                            .format(viewModel.event.startTime),
                      ),

                      verticalSpaceMedium,

                      // Start Time
                      _fieldLabel(
                        label: 'Start Time',
                        value:
                            DateFormat.jm().format(viewModel.event.startTime),
                      ),

                      verticalSpaceMedium,

                      // End Time
                      _fieldLabel(
                        label: 'End Time',
                        value: DateFormat.jm().format(viewModel.event.endTime),
                      ),

                      verticalSpaceMedium,

                      // Host
                      _fieldLabel(
                        label: 'Host',
                        value: viewModel.event.hostName,
                      ),

                      verticalSpaceMedium,

                      // Attendees
                      _fieldLabel(
                        label: 'Attendees',
                        value: viewModel.event.attendees.toString(),
                      ),

                      verticalSpaceMedium,

                      if (!viewModel.isUserHost)
                        RoundButton(
                          label: viewModel.canUnJoin
                              ? 'Leave Event'
                              : 'Join Event',
                          onPressed: () async => viewModel.canUnJoin
                              ? await viewModel.unJoinEventAsync()
                              : await viewModel.joinEventAsync(),
                        )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  //* Private Methods
  Widget _fieldLabel({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        verticalSpaceSmall,
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
