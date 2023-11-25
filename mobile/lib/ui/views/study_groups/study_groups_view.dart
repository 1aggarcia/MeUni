import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/study_group.dart';
import '../../widgets/i_event/i_events_view/i_events_view.dart';
import 'study_groups_viewmodel.dart';

class StudyGroupsView extends StackedView<StudyGroupsViewModel> {
  const StudyGroupsView({super.key});

  //* Overridden Methods
  @override
  StudyGroupsViewModel viewModelBuilder(BuildContext context) =>
      StudyGroupsViewModel();

  @override
  Widget builder(
      BuildContext context, StudyGroupsViewModel viewModel, Widget? child) {
    return IEventsView<StudyGroup>();
  }
}
