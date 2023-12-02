import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../loading_indicator.dart';
import '../../round_button.dart';
import '../i_event_card.dart';
import 'i_events_view.form.dart';
import 'i_events_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'searchEvent'),
  FormTextField(name: 'searchStudyGroup'),
])
class IEventsView<T extends IEvent> extends StackedView<IEventsViewModel>
    with $IEventsView {
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
  void onViewModelReady(IEventsViewModel<IEvent> viewModel) async {
    super.onViewModelReady(viewModel);

    syncFormWithViewModel(viewModel);
    await viewModel.getIEventsAsync();
  }

  @override
  Widget builder(
      BuildContext context, IEventsViewModel viewModel, Widget? child) {
    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          verticalSpaceSmall,

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller: T == Event
                  ? searchEventController
                  : searchStudyGroupController,
              onFieldSubmitted: (_) async => await viewModel.getIEventsAsync(),
              decoration: InputDecoration(
                hintText: 'Search ${_label}s',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (T == Event) {
                      searchEventController.clear();
                    } else {
                      searchStudyGroupController.clear();
                    }

                    await viewModel.getIEventsAsync();
                  },
                  icon: const Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.all(0),
              ),
            ),
          ),
          verticalSpaceSmall,

          // Events
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => await viewModel.getIEventsAsync(),
              child: viewModel.busy(viewModel.iEvents)
                  ? LoadingIndicator(
                      loadingText: 'Fetching ${_label}s',
                    )
                  : viewModel.iEvents.isEmpty
                      ? _noIEventIndicator()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: viewModel.iEvents.length,
                          separatorBuilder: (_, __) => verticalSpaceMedium,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () async =>
                                  viewModel.goToIEventDetailPageAsync(index),
                              child: IEventCard(
                                iEvent: viewModel.iEvents[index],
                              ),
                            );
                          },
                        ),
            ),
          ),

          verticalSpaceSmall,
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
