import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'study_group_detail_viewmodel.dart';

class StudyGroupDetailView extends StackedView<StudyGroupDetailViewModel> {
  //* Private Properties
  final String studyGroupId;

  //* Constructors
  const StudyGroupDetailView({
    super.key,
    required this.studyGroupId,
  });

  //* Overridden Methods
  @override
  StudyGroupDetailViewModel viewModelBuilder(BuildContext context) =>
      StudyGroupDetailViewModel();

  @override
  Widget builder(BuildContext context, StudyGroupDetailViewModel viewModel,
      Widget? child) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }
}
