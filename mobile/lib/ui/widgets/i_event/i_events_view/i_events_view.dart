import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'i_events_view_model.dart';

class IEventsView extends StackedView<IEventsViewModel> {
  const IEventsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    IEventsViewModel viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  IEventsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      IEventsViewModel();
}
