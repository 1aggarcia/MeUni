import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/study_groups/study_groups_viewmodel.dart';
import 'package:meuni_mobile/ui/widgets/study_group_card.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

class StudyGroupView extends StackedView<StudyGroupViewModel> {
  const StudyGroupView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, StudyGroupViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        body: viewModel.isLoading
            ? const Text('Loading...')
            : Container(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  children: [
                    Text('Hi! ${viewModel.userName}'),
                    verticalSpaceLarge,
                    Row(
                      children: [
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async => await viewModel.logoutAsync(),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async =>
                              await viewModel.getStudyGroupsAsync(),
                          child: const Text(
                            'Get Study Groups',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async =>
                              await viewModel.goToCreateStudyGroupPageAsync(),
                          child: const Text(
                            'Add Study Group',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    for (var studyGroup in viewModel.studyGroups) ...[
                      StudyGroupCard(studyGroup: studyGroup)
                    ]
                  ],
                )),
      ),
    );
  }

  @override
  StudyGroupViewModel viewModelBuilder(BuildContext context) =>
      StudyGroupViewModel();
}
