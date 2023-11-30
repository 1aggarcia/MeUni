import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/round_button.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  //* Private Properties
  final _labelTextStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  final _infoTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  //* Constructors
  const ProfileView({super.key});

  //* Overridden Methods
  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) async =>
      await viewModel.getClassesAsync();

  @override
  Widget builder(
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
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
                viewModel.user.fullName,
                style: _labelTextStyle,
              ),

              // Pronouns
              Text(
                '(${viewModel.user.pronouns})',
                style: _infoTextStyle,
              ),
              verticalSpaceMedium,

              // Year
              _fieldLabel(
                label: 'Year',
                value: viewModel.user.year.toString(),
              ),
              verticalSpaceMedium,

              // Classes
              viewModel.busy(viewModel.classes)
                  ? const LoadingIndicator(loadingText: 'Fetching Courses')
                  : _fieldLabel(
                      label: 'Courses',
                      value: viewModel.classes.toString(),
                    ),

              verticalSpaceMedium,

              RoundButton(
                label: 'Edit Courses',
                onPressed: () async => await viewModel.goToEditClassesPageAsync(),
              )
            ],
          ),
        ),
      ),
    );
  }

  //* Private Methods
  Widget _fieldLabel({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: _labelTextStyle,
        ),
        verticalSpaceSmall,
        Text(
          value,
          style: _infoTextStyle,
        ),
      ],
    );
  }
}
