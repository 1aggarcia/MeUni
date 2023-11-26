import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../loading_indicator.dart';
import '../../round_button.dart';
import 'i_event_detail_view_model.dart';

class IEventDetailView<T extends IEvent>
    extends StackedView<IEventDetailViewModel> {
  //* Private Properties
  final String _label = T == Event ? 'Event' : 'Study Group';

  //* Public Properties
  final String iEventId;

  //* Constructors
  IEventDetailView({
    super.key,
    required this.iEventId,
  });

  //* Overridden Methods
  @override
  IEventDetailViewModel viewModelBuilder(BuildContext context) =>
      IEventDetailViewModel<T>(iEventId);

  @override
  void onViewModelReady(IEventDetailViewModel<IEvent> viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) async => await viewModel.getIEventAsync());

  @override
  Widget builder(
      BuildContext context, IEventDetailViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$_label Detail'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? LoadingIndicator(loadingText: 'Loading $_label Details')
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      // Title
                      _fieldLabel(
                        label: T == Event ? 'Title' : 'Course',
                        value: viewModel.iEvent.title,
                      ),

                      verticalSpaceMedium,

                      // Description
                      _fieldLabel(
                        label: 'Description',
                        value: viewModel.iEvent.desc,
                      ),

                      verticalSpaceMedium,

                      // Location
                      _fieldLabel(
                        label: 'Location',
                        value: viewModel.iEvent.location,
                      ),

                      verticalSpaceMedium,

                      // Date
                      _fieldLabel(
                        label: 'Date',
                        value: DateFormat.MMMEd()
                            .format(viewModel.iEvent.startTime),
                      ),

                      verticalSpaceMedium,

                      // Start Time
                      _fieldLabel(
                        label: 'Start Time',
                        value:
                            DateFormat.jm().format(viewModel.iEvent.startTime),
                      ),

                      verticalSpaceMedium,

                      // End Time
                      _fieldLabel(
                        label: 'End Time',
                        value: DateFormat.jm().format(viewModel.iEvent.endTime),
                      ),

                      verticalSpaceMedium,

                      // Host
                      _fieldLabel(
                        label: 'Host',
                        value: viewModel.iEvent.hostName,
                      ),

                      verticalSpaceMedium,

                      // Attendees
                      _fieldLabel(
                        label: 'Attendees',
                        value: viewModel.iEvent.attendees.toString(),
                      ),

                      verticalSpaceMedium,

                      if (!viewModel.isUserHost)
                        RoundButton(
                          label: viewModel.canUnJoin
                              ? 'Leave $_label'
                              : 'Join $_label',
                          onPressed: () async => viewModel.canUnJoin
                              ? await viewModel.unJoinIEventAsync()
                              : await viewModel.joinIEventAsync(),
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
