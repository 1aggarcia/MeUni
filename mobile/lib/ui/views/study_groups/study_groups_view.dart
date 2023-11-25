import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/i_event_card.dart';
import 'study_groups_viewmodel.dart';

class StudyGroupsView extends StackedView<StudyGroupsViewModel> {
  const StudyGroupsView({super.key});

  @override
  Widget builder(
      BuildContext context, StudyGroupsViewModel viewModel, Widget? child) {
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
                      IEventCard(iEvent: studyGroup)
                    ]
                  ],
                )),
      ),
    );
  }

  @override
  StudyGroupsViewModel viewModelBuilder(BuildContext context) =>
      StudyGroupsViewModel();
}
