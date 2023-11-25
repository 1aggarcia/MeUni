import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'create_study_group_view.form.dart';
import 'create_study_group_viewmodel.dart';

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
  const CreateStudyGroupView({super.key});

  @override
  Widget builder(BuildContext context, CreateStudyGroupViewModel viewModel,
      Widget? child) {
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
                      TextFormField(
                        controller: studyGroupCourseController,
                        decoration: InputDecoration(
                          labelText: 'Study Group Course Name',
                          errorText:
                              viewModel.studyGroupCourseValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Study Group Description
                      TextFormField(
                        controller: studyGroupDescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Study Group Description',
                          errorText:
                              viewModel.studyGroupDescriptionValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Study Group Location
                      TextFormField(
                        controller: studyGroupLocationController,
                        decoration: InputDecoration(
                          labelText: 'Study Group Location',
                          errorText:
                              viewModel.studyGroupLocationValidationMessage,
                        ),
                      ),

                      verticalSpaceSmall,

                      // Study Group Date
                      TextFormField(
                        controller: studyGroupDateController,
                        decoration: InputDecoration(
                          labelText: 'Study Group Date',
                          errorText: viewModel.studyGroupDateValidationMessage,
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

                      verticalSpaceSmall,

                      // Study Group Start Time
                      TextFormField(
                        controller: studyGroupStartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Study Group Start Time',
                          errorText:
                              viewModel.studyGroupStartTimeValidationMessage,
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

                      verticalSpaceSmall,

                      // Study Group End Time
                      TextFormField(
                        controller: studyGroupEndTimeController,
                        decoration: InputDecoration(
                          labelText: 'Study Group End Time',
                          errorText:
                              viewModel.studyGroupEndTimeValidationMessage,
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

                      verticalSpaceSmall,

                      // Add Study Group Button
                      MaterialButton(
                        color: kcTextPrimaryColor,
                        onPressed: () async =>
                            await viewModel.addStudyGroupAsync(),
                        child: const Text(
                          'Add Study Group',
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
