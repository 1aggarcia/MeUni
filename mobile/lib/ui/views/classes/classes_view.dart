import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

import '../../widgets/loading_indicator.dart';
import '../../widgets/round_button.dart';
import 'classes.dart';
import 'classes_view.form.dart';
import 'classes_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'prefix',
  ),
  FormTextField(
    name: 'courseCode',
    validator: ClassValidators.validateCourseCode,
  ),
])
class ClassesView extends StackedView<ClassesViewModel> with $ClassesView {
  const ClassesView({super.key});

  //* Overridden Methods
  @override
  ClassesViewModel viewModelBuilder(BuildContext context) => ClassesViewModel();

  @override
  void onViewModelReady(ClassesViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  Widget builder(
      BuildContext context, ClassesViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Class'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? const LoadingIndicator(loadingText: 'Adding Class')
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpaceSmall,

                    // Prefix
                    DropdownButtonFormField(
                      decoration:
                          const InputDecoration(labelText: 'Course Prefix'),
                      items: classPrefixes
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          prefixController.text = value;
                        }
                      },
                      value: prefixController.text.isNotEmpty
                          ? prefixController.text
                          : null,
                    ),

                    verticalSpaceMedium,

                    // Suffix
                    TextFormField(
                      controller: courseCodeController,
                      decoration: InputDecoration(
                          labelText: 'Course Code',
                          errorText: viewModel.courseCodeValidationMessage),
                    ),

                    verticalSpaceMedium,

                    // Add Class
                    RoundButton(
                      label: 'Add Class',
                      onPressed: () async => await viewModel.addClassAsync(),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
