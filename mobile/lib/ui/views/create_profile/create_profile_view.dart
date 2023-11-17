import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_profile_viewmodel.dart';

class CreateProfileView extends StackedView<CreateProfileViewModel> {
  //* Private Properties
  final String userId;

  //* Constructors
  const CreateProfileView({
    Key? key,
    required this.userId,
  }) : super(key: key);

  //* Overriden Methods
  @override
  Widget builder(
      BuildContext context, CreateProfileViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Text(userId),
      ),
    );
  }

  @override
  CreateProfileViewModel viewModelBuilder(BuildContext context) =>
      CreateProfileViewModel(userId: userId);
}
