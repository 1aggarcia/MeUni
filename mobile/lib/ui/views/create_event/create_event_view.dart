import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import 'create_event_view.form.dart';
import 'create_event_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'eventName',
    validator: CreateEventValidators.validateEventName,
  ),
  FormTextField(
    name: 'eventDescription',
    validator: CreateEventValidators.validateEventDescription,
  ),
  FormTextField(
    name: 'eventLocation',
    validator: CreateEventValidators.validateEventLocation,
  ),
  FormTextField(
    name: 'eventDate',
    validator: CreateEventValidators.validateEventDate,
  ),
  FormTextField(
    name: 'eventStartTime',
    validator: CreateEventValidators.validateEventStartTime,
  ),
  FormTextField(
    name: 'eventEndTime',
    validator: CreateEventValidators.validateEventEndTime,
  ),
])
class CreateEventView extends StackedView<CreateEventViewModel>
    with $CreateEventView {
  const CreateEventView({Key? key}) : super(key: key);

  //* Overriden Methods
  @override
  CreateEventViewModel viewModelBuilder(BuildContext context) =>
      CreateEventViewModel();

  @override
  void onViewModelReady(CreateEventViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  void onDispose(CreateEventViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  Widget builder(
      BuildContext context, CreateEventViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Event'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? const LoadingIndicator(loadingText: 'Creating Event')
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Name
                      TextFormField(
                        controller: eventNameController,
                        decoration: InputDecoration(
                          labelText: 'Event Name',
                          errorText: viewModel.eventNameValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Description
                      TextFormField(
                        controller: eventDescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Event Description',
                          errorText:
                              viewModel.eventDescriptionValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Location
                      TextFormField(
                        controller: eventLocationController,
                        decoration: InputDecoration(
                          labelText: 'Event Location',
                          errorText: viewModel.eventLocationValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Date
                      TextFormField(
                        controller: eventDateController,
                        decoration: InputDecoration(
                          labelText: 'Event Date',
                          errorText: viewModel.eventDateValidationMessage,
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (picked != null) {
                            eventDateController.text = picked.toString();
                          }
                        },
                      ),

                      verticalSpaceSmall,

                      // Event Start Time
                      TextFormField(
                        controller: eventStartTimeController,
                        decoration: InputDecoration(
                            labelText: 'Event Start Time',
                            errorText:
                                viewModel.eventStartTimeValidationMessage),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );
                          if (picked != null && picked != time) {
                            eventStartTimeController.text =
                                // ignore: use_build_context_synchronously
                                picked.format(context);
                          }
                        },
                      ),

                      verticalSpaceSmall,

                      // Event End Time
                      TextFormField(
                        controller: eventEndTimeController,
                        decoration: InputDecoration(
                          labelText: 'Event End Time',
                          errorText: viewModel.eventEndTimeValidationMessage,
                        ),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );
                          if (picked != null && picked != time) {
                            eventEndTimeController.text =
                                // ignore: use_build_context_synchronously
                                picked.format(context);
                          }
                        },
                      ),

                      verticalSpaceSmall,

                      // Add Event Button
                      MaterialButton(
                        color: kcPrimaryColor,
                        disabledColor: kcPrimaryColor.withAlpha(100),
                        onPressed: viewModel.isFormValid
                            ? () async => await viewModel.addEventAsync()
                            : null,
                        child: const Text(
                          'Add Event',
                          style: TextStyle(color: kcSecondaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
