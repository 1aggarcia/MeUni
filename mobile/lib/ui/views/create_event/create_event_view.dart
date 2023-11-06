import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import 'create_event_view.form.dart';
import 'create_event_viewmodel.dart';

@FormView(fields: [
  FormTextField(
      name: 'eventName', validator: CreateEventValidators.validateEventName),
])
class CreateEventView extends StackedView<CreateEventViewModel>
    with $CreateEventView {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateEventViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Event')),
        body: viewModel.isLoading
            ? const Text('Loading...')
            : Container(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      const Text(
                        'Event Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(controller: eventNameController),
                      if (viewModel.hasEventNameValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventNameValidationMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      MaterialButton(
                        color: Colors.black,
                        onPressed: () async => await viewModel.addEventAsync(),
                        child: const Text(
                          'Add Event',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  CreateEventViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateEventViewModel();

  @override
  void onViewModelReady(CreateEventViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(CreateEventViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
