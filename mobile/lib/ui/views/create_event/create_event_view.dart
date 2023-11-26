import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/event.dart';
import '../../widgets/i_event/create_i_event_view/create_i_event_view.dart';
import 'create_event_viewmodel.dart';

class CreateEventView extends StackedView<CreateEventViewModel> {
  const CreateEventView({super.key});

  //* Overridden Methods
  @override
  CreateEventViewModel viewModelBuilder(BuildContext context) =>
      CreateEventViewModel();

  @override
  Widget builder(
      BuildContext context, CreateEventViewModel viewModel, Widget? child) {
    return CreateIEventView<Event>();
  }
}
