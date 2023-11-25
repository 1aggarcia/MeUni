import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/i_event/i_event_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/round_button.dart';
import 'events_viewmodel.dart';

class EventsView extends StackedView<EventsViewModel> {
  const EventsView({super.key});

  //* Overridden Methods
  @override
  EventsViewModel viewModelBuilder(BuildContext context) => EventsViewModel();

  @override
  Widget builder(
      BuildContext context, EventsViewModel viewModel, Widget? child) {
    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          RoundButton(
            label: 'Get Events',
            onPressed: viewModel.busy(viewModel.events)
                ? null
                : () async => await viewModel.getEventsAsync(),
          ),
          verticalSpaceLarge,

          //* Show all the Events
          if (viewModel.busy(viewModel.events))
            const LoadingIndicator(
              loadingText: 'Fetching Events',
            )
          else if (viewModel.events.isEmpty)
            _noEventIndicator()
          else
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () async =>
                        viewModel.goToEventDetailPageAsync(index),
                    child: IEventCard(
                      iEvent: viewModel.events[index],
                    ),
                  );
                },
                separatorBuilder: (_, __) => verticalSpaceMedium,
                itemCount: viewModel.events.length,
              ),
            ),

          verticalSpaceMedium,
          RoundButton(
            label: 'Add an Event',
            onPressed: () async => await viewModel.goToCreateEventPageAsync(),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  //* Private Methods
  Widget _noEventIndicator() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 40,
          ),
          horizontalSpaceSmall,
          Text(
            'No Events',
            style: TextStyle(
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
