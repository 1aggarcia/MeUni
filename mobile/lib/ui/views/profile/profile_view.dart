import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {

    const labelTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    const infoTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,

              // First Name
              const Text(
                'First Name',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              Text(
                viewModel.firstName,
                style: infoTextStyle,
              ),
              verticalSpaceMedium,

              // Last Name
              const Text(
                'Last Name',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              Text(
                viewModel.lastName,
                style: infoTextStyle,
              ),
              verticalSpaceMedium,

              // Pronouns
              const Text(
                'Pronouns',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              Text(
                viewModel.pronouns,
                style: infoTextStyle,
              ),
              verticalSpaceMedium,

              // Year
              const Text(
                'Year',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              Text(
                viewModel.year.toString(),
                style: infoTextStyle,
              ),
              verticalSpaceMedium,

              // Year
              const Text(
                'Classes',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              Text(
                viewModel.classes.toString(),
                style: infoTextStyle,
              ),
              verticalSpaceMedium,

              MaterialButton(
                color: Colors.black,
                onPressed: () async => (),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) {
    ProfileViewModel model = ProfileViewModel();
    model.getClassesAsync();
    return model;
  }

}
