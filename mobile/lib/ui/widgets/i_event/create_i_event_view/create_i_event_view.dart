import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../../models/event.dart';
import '../../../../models/i_event.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../loading_indicator.dart';
import 'create_i_event_view.form.dart';
import 'create_i_event_view_model.dart';

@FormView(fields: [
  FormTextField(
    name: 'iEventName',
    validator: CreateIEventValidators.validateName,
  ),
  FormTextField(
    name: 'iEventDescription',
    validator: CreateIEventValidators.validateDescription,
  ),
  FormTextField(
    name: 'iEventLocation',
    validator: CreateIEventValidators.validateLocation,
  ),
  FormTextField(
    name: 'iEventMax',
    validator: CreateIEventValidators.validateMax,
  ),
  FormTextField(
    name: 'iEventDate',
    validator: CreateIEventValidators.validateDate,
  ),
  FormTextField(
    name: 'iEventStartTime',
    validator: CreateIEventValidators.validateStartTime,
  ),
  FormTextField(
    name: 'iEventEndTime',
    validator: CreateIEventValidators.validateEndTime,
  ),
])
class CreateIEventView<T extends IEvent>
    extends StackedView<CreateIEventViewModel> with $CreateIEventView {
  //* Private Properties
  final String _label = T == Event ? 'Event' : 'Study Group';

  //* Constructors
  CreateIEventView({super.key});

  //* Overridden Methods
  @override
  CreateIEventViewModel viewModelBuilder(BuildContext context) =>
      CreateIEventViewModel<T>();

  @override
  void onViewModelReady(CreateIEventViewModel<IEvent> viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(CreateIEventViewModel<IEvent> viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  Widget builder(
      BuildContext context, CreateIEventViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create $_label'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? LoadingIndicator(loadingText: 'Creating $_label')
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Name
                      TextFormField(
                        controller: iEventNameController,
                        decoration: InputDecoration(
                          labelText: '$_label Name',
                          errorText: viewModel.iEventNameValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Description
                      TextFormField(
                        controller: iEventDescriptionController,
                        decoration: InputDecoration(
                          labelText: '$_label Description',
                          errorText:
                              viewModel.iEventDescriptionValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Location
                      TextFormField(
                        controller: iEventLocationController,
                        decoration: InputDecoration(
                          labelText: '$_label Location',
                          errorText: viewModel.iEventLocationValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Max
                      TextFormField(
                        controller: iEventMaxController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '$_label Max',
                          errorText: viewModel.iEventMaxValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Event Date
                      TextFormField(
                        controller: iEventDateController,
                        decoration: InputDecoration(
                          labelText: '$_label Date',
                          errorText: viewModel.iEventDateValidationMessage,
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
                            iEventDateController.text = picked.toString();
                          }
                        },
                      ),

                      verticalSpaceSmall,

                      // Event Start Time
                      TextFormField(
                        controller: iEventStartTimeController,
                        decoration: InputDecoration(
                            labelText: '$_label Start Time',
                            errorText:
                                viewModel.iEventStartTimeValidationMessage),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );
                          if (picked != null && picked != time) {
                            iEventStartTimeController.text =
                                // ignore: use_build_context_synchronously
                                picked.format(context);
                          }
                        },
                      ),

                      verticalSpaceSmall,

                      // Event End Time
                      TextFormField(
                        controller: iEventEndTimeController,
                        decoration: InputDecoration(
                          labelText: '$_label End Time',
                          errorText: viewModel.iEventEndTimeValidationMessage,
                        ),
                        onTap: () async {
                          TimeOfDay time = TimeOfDay.now();
                          FocusScope.of(context).requestFocus(FocusNode());

                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: time,
                          );
                          if (picked != null && picked != time) {
                            iEventEndTimeController.text =
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
                            ? () async => await viewModel.addIEventAsync()
                            : null,
                        child: Text(
                          'Add $_label',
                          style: const TextStyle(color: kcSecondaryColor),
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
