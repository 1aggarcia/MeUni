import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../loading_indicator.dart';
import '../../round_button.dart';
import '../i_event_card.dart';
import 'i_events_view_model.dart';

class IEventsView<T extends IEvent> extends StackedView<IEventsViewModel> {
  //* Private Properties
  final String _label = T == Event ? 'Event' : 'Study Group';
  final String _article = T == Event ? 'an' : 'a';

  //* Constructors
  IEventsView({super.key});

  //* Overridden Methods
  @override
  IEventsViewModel viewModelBuilder(BuildContext context) =>
      IEventsViewModel<T>();

  @override
  Widget builder(
      BuildContext context, IEventsViewModel viewModel, Widget? child) {
    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          RoundButton(
            label: 'Get ${_label}s',
            onPressed: viewModel.busy(viewModel.iEvents)
                ? null
                : () async => await viewModel.getIEventsAsync(),
          ),
          verticalSpaceLarge,

          //* Show all the IEvents
          if (viewModel.busy(viewModel.iEvents))
            LoadingIndicator(
              loadingText: 'Fetching ${_label}s',
            )
          else if (viewModel.iEvents.isEmpty)
            _noIEventIndicator()
          else
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () async =>
                        viewModel.goToIEventDetailPageAsync(index),
                    child: IEventCard(
                      iEvent: viewModel.iEvents[index],
                    ),
                  );
                },
                separatorBuilder: (_, __) => verticalSpaceMedium,
                itemCount: viewModel.iEvents.length,
              ),
            ),

          verticalSpaceMedium,
          RoundButton(
            label: 'Add $_article $_label',
            onPressed: () async => await viewModel.goToCreateIEventPageAsync(),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  //* Private Methods
  Widget _noIEventIndicator() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 40,
          ),
          horizontalSpaceSmall,
          Text(
            'No ${_label}s',
            style: const TextStyle(
              color: kcTextAccentColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
