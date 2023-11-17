import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import 'create_studygroup_view.form.dart';
import 'create_studygroup_viewmodel.dart';
import '../text_input.dart';

@FormView(fields: [
  FormTextField(
    name: 'studyGroupCourse',
    validator: CreateStudyGroupValidators.validateStudyGroupCourse,
  ),
  FormTextField(
    name: 'studyGroupDescription',
    validator: CreateStudyGroupValidators.validateStudyGroupDescription,
  ),
  FormTextField(
    name: 'studyGroupLocation',
    validator: CreateStudyGroupValidators.validateStudyGroupLocation,
  ),
  FormTextField(
    name: 'studyGroupDate',
    validator: CreateStudyGroupValidators.validateStudyGroupDate,
  ),
  FormTextField(
    name: 'studyGroupStartTime',
    validator: CreateStudyGroupValidators.validateStudyGroupStartTime,
  ),
  FormTextField(
    name: 'studyGroupEndTime',
    validator: CreateStudyGroupValidators.validateStudyGroupEndTime,
  ),
])
class CreateStudyGroupView extends StackedView<CreateStudyGroupViewModel>
    with $CreateStudyGroupView {
  const CreateStudyGroupView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, CreateStudyGroupViewModel viewModel, Widget? child) {
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
        appBar: AppBar(title: const Text('Create Study Group')),
        body: viewModel.isLoading
            ? const Text('Loading...')
            : Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,

                // StudyGroup Course Name
                TextInput(
                  label: 'Study Group Course Name',
                  placeholder: 'Course Name',
                  labelTextStyle: labelTextStyle,
                  errorTextStyle: errorTextStyle,
                  controller: studyGroupCourseController,
                  hasValidationMessage:
                  viewModel.hasStudyGroupCourseValidationMessage,
                  validationMessage: viewModel.studyGroupCourseValidationMessage,
                ),

                verticalSpaceSmall,

                // Study Group Description
                TextInput(
                  label: 'Study Group Description',
                  placeholder: 'Description',
                  labelTextStyle: labelTextStyle,
                  errorTextStyle: errorTextStyle,
                  controller: studyGroupDescriptionController,
                  hasValidationMessage:
                  viewModel.hasStudyGroupDescriptionValidationMessage,
                  validationMessage:
                  viewModel.studyGroupDescriptionValidationMessage,
                ),

                verticalSpaceSmall,

                // Study Group Location
                TextInput(
                  label: 'Study Group Location',
                  placeholder: 'Location',
                  labelTextStyle: labelTextStyle,
                  errorTextStyle: errorTextStyle,
                  controller: studyGroupLocationController,
                  hasValidationMessage:
                  viewModel.hasStudyGroupLocationValidationMessage,
                  validationMessage:
                  viewModel.studyGroupLocationValidationMessage,
                ),

                verticalSpaceSmall,

                // Study Group Date
                const Text(
                  'Study Group Date (yyyy-mm-dd)',
                  style: labelTextStyle,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: studyGroupDateController,
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
                      studyGroupDateController.text = picked.toString();
                    }
                  },
                ),
                if (viewModel.hasStudyGroupDateValidationMessage) ...[
                  verticalSpaceTiny,
                  Text(
                    viewModel.studyGroupDateValidationMessage!,
                    style: errorTextStyle,
                  ),
                ],

                verticalSpaceSmall,

                // Study Group Start Time
                const Text(
                  'Study Group Start Time',
                  style: labelTextStyle,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: studyGroupStartTimeController,
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
                      studyGroupStartTimeController.text =
                      // ignore: use_build_context_synchronously
                      picked.format(context);
                    }
                  },
                ),
                if (viewModel.hasStudyGroupStartTimeValidationMessage) ...[
                  verticalSpaceTiny,
                  Text(
                    viewModel.studyGroupStartTimeValidationMessage!,
                    style: errorTextStyle,
                  ),
                ],

                verticalSpaceSmall,

                // Study Group End Time
                const Text(
                  'Study Group End Time',
                  style: labelTextStyle,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: studyGroupEndTimeController,
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
                      studyGroupEndTimeController.text =
                      // ignore: use_build_context_synchronously
                      picked.format(context);
                    }
                  },
                ),
                if (viewModel.hasStudyGroupEndTimeValidationMessage) ...[
                  verticalSpaceTiny,
                  Text(
                    viewModel.studyGroupEndTimeValidationMessage!,
                    style: errorTextStyle,
                  ),
                ],

                verticalSpaceSmall,

                // Add Study Group Button
                MaterialButton(
                  color: Colors.black,
                  onPressed: () async => await viewModel.addStudyGroupAsync(),
                  child: const Text(
                    'Add Study Group',
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
  CreateStudyGroupViewModel viewModelBuilder(BuildContext context) =>
      CreateStudyGroupViewModel();

  @override
  void onViewModelReady(CreateStudyGroupViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  void onDispose(CreateStudyGroupViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
