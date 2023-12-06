import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../loading_indicator.dart';
import '../../missing_indicator.dart';
import '../../round_button.dart';
import 'i_event_detail_view_model.dart';

class IEventDetailView<T extends IEvent>
    extends StackedView<IEventDetailViewModel> {
  //* Private Properties
  final String _label = T == Event ? 'Event' : 'Study Group';

  final TextStyle _labelTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _valueTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

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
  Widget builder(
      BuildContext context, IEventDetailViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(viewModel.isBusy ? 'Loading ...' : viewModel.iEvent.title),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? LoadingIndicator(loadingText: 'Loading $_label Details')
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Center(
                  child: Column(
                    children: [
                      // Title
                      _fieldLabel(
                          label: 'Full Title', value: viewModel.iEvent.title),

                      verticalSpaceMedium,

                      // Description
                      _fieldLabel(
                          label: 'Description', value: viewModel.iEvent.desc),

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
                      Text(
                        'Attendees (${viewModel.iEvent.attendees.length}/'
                        '${viewModel.iEvent.max})',
                        style: _labelTextStyle,
                      ),
                      verticalSpaceSmall,
                      viewModel.iEvent.attendeeNames.isEmpty
                          ? const MissingIndicator(label: 'No Attendees')
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, __) => verticalSpaceTiny,
                              itemCount: viewModel.iEvent.attendeeNames.length,
                              itemBuilder: (_, index) {
                                return Center(
                                  child: Text(
                                    viewModel.iEvent.attendeeNames[index],
                                    style: _valueTextStyle,
                                  ),
                                );
                              },
                            ),

                      verticalSpaceMedium,

                      if (!viewModel.isUserHost) ...[
                        RoundButton(
                          label: viewModel.canUnJoin
                              ? 'Leave $_label'
                              : 'Join $_label',
                          onPressed: () async => viewModel.canUnJoin
                              ? await viewModel.unJoinIEventAsync()
                              : await viewModel.joinIEventAsync(),
                        )
                      ] else
                        RoundButton(
                          label: 'Delete $_label',
                          onPressed: () async =>
                              await viewModel.deleteIEventAsync(),
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
          style: _labelTextStyle,
        ),
        verticalSpaceTiny,
        Text(
          value,
          style: _valueTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
