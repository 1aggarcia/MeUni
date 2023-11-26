import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/study_group.dart';
import '../../widgets/i_event/i_event_detail_view/i_event_detail_view.dart';
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
    return IEventDetailView<StudyGroup>(iEventId: studyGroupId);
  }
}
