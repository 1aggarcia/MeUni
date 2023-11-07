import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import 'create_event_view.form.dart';
import 'create_event_viewmodel.dart';

@FormView(fields: [
  FormTextField(
      name: 'eventName', validator: CreateEventValidators.validateEventName),
  FormTextField(name: 'eventDescription', validator: CreateEventValidators.validateEventDescription),
  FormTextField(name: 'eventLocation', validator: CreateEventValidators.validateEventLocation),
  FormTextField(name: 'eventDate', validator: CreateEventValidators.validateEventDate),
  FormTextField(name: 'eventStartTime', validator: CreateEventValidators.validateEventStartTime),
  FormTextField(name: 'eventEndTime', validator: CreateEventValidators.validateEventEndTime),

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
                      TextFormField(
                        controller: eventNameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
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
                      const Text(
                        'Event Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventDescriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                      if (viewModel.hasEventDescriptionValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventDescriptionValidationMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      const Text(
                        'Event Location',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                          controller: eventLocationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                          ),
                      ),
                      if (viewModel.hasEventLocationValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventLocationValidationMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      const Text(
                        'Event Date (yyyy-mm-dd)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventDateController,  // add this line.
                        decoration: const InputDecoration(
                          labelText: 'Date',
                        ),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2019)
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
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      const Text(
                        'Event Start Time',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventStartTimeController,  // add this line.
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                        ),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked =
                          await showTimePicker(context: context, initialTime: time);
                          if (picked != null && picked != time) {
                            eventStartTimeController.text = picked.format(context);  // add this line.
                          }
                        },
                      ),
                      if (viewModel.hasEventStartTimeValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventStartTimeValidationMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      const Text(
                        'Event End Time',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        controller: eventEndTimeController,  // add this line.
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                        ),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked =
                          await showTimePicker(context: context, initialTime: time);
                          if (picked != null && picked != time) {
                            eventEndTimeController.text = picked.format(context);  // add this line.
                          }
                        },
                      ),
                      if (viewModel.hasEventEndTimeValidationMessage) ...[
                        verticalSpaceTiny,
                        Text(
                          viewModel.eventEndTimeValidationMessage!,
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
