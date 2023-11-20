import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

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
  const CreateProfileView({Key? key}) : super(key: key);

  //* Overridden Methods
  @override
  Widget builder(
      BuildContext context, CreateProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Creating Profile ...",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceMedium,
                    CircularProgressIndicator(),
                  ],
                ),
              )
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
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.add_a_photo,
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
                      decoration: const InputDecoration(labelText: 'Year'),
                    ),
                    if (viewModel.hasYearValidationMessage) ...[
                      verticalSpaceTiny,
                      Text(
                        viewModel.yearValidationMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],

                    verticalSpaceSmall,

                    // Pronouns
                    TextFormField(
                      controller: pronounsController,
                      decoration: const InputDecoration(labelText: 'Pronouns'),
                    ),

                    verticalSpaceMedium,

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
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

  @override
  CreateProfileViewModel viewModelBuilder(BuildContext context) =>
      CreateProfileViewModel();

  @override
  void onViewModelReady(CreateProfileViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(CreateProfileViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
