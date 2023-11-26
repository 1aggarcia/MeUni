import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/study_group.dart';
import '../../widgets/i_event/create_i_event_view/create_i_event_view.dart';
import 'create_study_group_viewmodel.dart';

class CreateStudyGroupView extends StackedView<CreateStudyGroupViewModel> {
  const CreateStudyGroupView({super.key});

  //* Overridden Methods
  @override
  CreateStudyGroupViewModel viewModelBuilder(BuildContext context) =>
      CreateStudyGroupViewModel();

  @override
  Widget builder(BuildContext context, CreateStudyGroupViewModel viewModel,
      Widget? child) {
    return CreateIEventView<StudyGroup>();
  }
}
