import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import 'create_profile_view.form.dart';
import 'create_profile_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'firstName'),
  FormTextField(name: 'lastName'),
  FormTextField(
    name: 'year',
    validator: CreateProfileValidators.validateYear,
  ),
  FormTextField(name: 'pronouns'),
])
class CreateProfileView extends StackedView<CreateProfileViewModel>
    with $CreateProfileView {
  //* Constructors
  const CreateProfileView({super.key});

  //* Overridden Methods
  @override
  CreateProfileViewModel viewModelBuilder(BuildContext context) =>
      CreateProfileViewModel();

  @override
  void onViewModelReady(CreateProfileViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  void onDispose(CreateProfileViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  Widget builder(
      BuildContext context, CreateProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: viewModel.isBusy
            ? const LoadingIndicator(loadingText: 'Creating Profile')
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Let's get you set up!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceLarge,

                    // Adding a profile picture
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: kcMediumGrey.withAlpha(150),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: kcPrimaryColor,
                          size: 50,
                        ),
                      ),
                    ),

                    verticalSpaceLarge,

                    // First Name
                    TextFormField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First name'),
                    ),

                    verticalSpaceSmall,

                    // Last Name
                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last name'),
                    ),

                    verticalSpaceSmall,

                    // Year
                    TextFormField(
                      controller: yearController,
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Year',
                        errorText: viewModel.yearValidationMessage,
                      ),
                    ),

                    verticalSpaceSmall,

                    // Pronouns
                    TextFormField(
                      controller: pronounsController,
                      decoration: const InputDecoration(labelText: 'Pronouns'),
                    ),

                    verticalSpaceMedium,

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcPrimaryColor,
                        foregroundColor: kcSecondaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async =>
                          await viewModel.createProfileAsync(),
                      child: const Text('Create Profile'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
