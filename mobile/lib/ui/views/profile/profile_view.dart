import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
    const labelTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );

    const infoTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    return Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: kcMediumGrey.withAlpha(150),
                child: const Icon(
                  Icons.person_2_outlined,
                  color: kcPrimaryColor,
                  size: 90,
                ),
              ),
              verticalSpaceMedium,

              // Name
              Text(
                '${viewModel.firstName.titleCase} ${viewModel.lastName.titleCase}',
                style: labelTextStyle,
              ),

              // Pronouns
              Text(
                '(${viewModel.pronouns})',
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
  ProfileViewModel viewModelBuilder(BuildContext context) {
    ProfileViewModel model = ProfileViewModel();
    unawaited(model.getClassesAsync());
    return model;
  }
}
