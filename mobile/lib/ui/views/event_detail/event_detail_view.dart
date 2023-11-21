import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/round_button.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        body: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: [
                RoundButton(
                  label: 'Go Back',
                  onPressed: viewModel.goBack,
                ),
                verticalSpaceMedium,
                Text(eventId),
              ],
            )),
      ),
    );
  }

  @override
  EventDetailViewModel viewModelBuilder(BuildContext context) =>
      EventDetailViewModel(eventId);
}
