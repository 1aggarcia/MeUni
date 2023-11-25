import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'study_group_detail_viewmodel.dart';

class StudyGroupDetailView extends StackedView<StudyGroupDetailViewModel> {
  const StudyGroupDetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudyGroupDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  StudyGroupDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StudyGroupDetailViewModel();
}
