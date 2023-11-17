import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import 'create_event_view.form.dart';
import 'create_event_viewmodel.dart';
import '../text_input.dart';

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

  @override
  Widget builder(
      BuildContext context, CreateEventViewModel viewModel, Widget? child) {
    const labelTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    const errorTextStyle = TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );

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

                      // Event Name
                      TextInput(
                        label: 'Event Name',
                        placeholder: 'Name',
                        labelTextStyle: labelTextStyle,
                        errorTextStyle: errorTextStyle,
                        controller: eventNameController,
                        hasValidationMessage:
                            viewModel.hasEventNameValidationMessage,
                        validationMessage: viewModel.eventNameValidationMessage,
                      ),

                      verticalSpaceSmall,

                      // Event Description
                      TextInput(
                        label: 'Event Description',
                        placeholder: 'Description',
                        labelTextStyle: labelTextStyle,
                        errorTextStyle: errorTextStyle,
                        controller: eventDescriptionController,
                        hasValidationMessage:
                            viewModel.hasEventDescriptionValidationMessage,
                        validationMessage:
                            viewModel.eventDescriptionValidationMessage,
                      ),

                      verticalSpaceSmall,

                      // Event Location
                      TextInput(
                        label: 'Event Location',
                        placeholder: 'Location',
                        labelTextStyle: labelTextStyle,
                        errorTextStyle: errorTextStyle,
                        controller: eventLocationController,
                        hasValidationMessage:
                            viewModel.hasEventLocationValidationMessage,
                        validationMessage:
                            viewModel.eventLocationValidationMessage,
                      ),

                      verticalSpaceSmall,

                      // Event Date
                      const Text(
                        'Event Date (yyyy-mm-dd)',
                        style: labelTextStyle,
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventDateController,
                        decoration: const InputDecoration(
                          labelText: 'Date',
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (picked != null) {
                            eventDateController.text = picked.toString();
                          }
                        },
                      ),
                      if (viewModel.hasEventDateValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventDateValidationMessage!,
                          style: errorTextStyle,
                        ),
                      ],

                      verticalSpaceSmall,

                      // Event Start Time
                      const Text(
                        'Event Start Time',
                        style: labelTextStyle,
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventStartTimeController,
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                        ),
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
                      if (viewModel.hasEventStartTimeValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventStartTimeValidationMessage!,
                          style: errorTextStyle,
                        ),
                      ],

                      verticalSpaceSmall,

                      // Event End Time
                      const Text(
                        'Event End Time',
                        style: labelTextStyle,
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventEndTimeController,
                        decoration: const InputDecoration(
                          labelText: 'End Time',
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
                      if (viewModel.hasEventEndTimeValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventEndTimeValidationMessage!,
                          style: errorTextStyle,
                        ),
                      ],

                      verticalSpaceSmall,

                      // Add Event Button
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
}
