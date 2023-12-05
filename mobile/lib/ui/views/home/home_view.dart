import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../events/events_view.dart';
import '../profile/profile_view.dart';
import '../study_groups/study_groups_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  //* Public Properties
  NavView? initialView;

  //* Constructors
  HomeView({super.key, this.initialView});

  //* Overridden Methods
  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel(initialView);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'MeUni',
            style: TextStyle(
              color: kcTextAccentColor,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: kcBackgroundColor,
        body: _getViewForView(viewModel.currentView),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kcMediumGrey,
          currentIndex: viewModel.currentIndex,
          selectedItemColor: kcTextAccentColor,
          unselectedItemColor: kcPrimaryColor,
          onTap: viewModel.setIndex,
          items: [
            BottomNavigationBarItem(
              icon: viewModel.currentView == NavView.Events
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: viewModel.currentView == NavView.StudyGroups
                  ? const Icon(Icons.book)
                  : const Icon(Icons.book_outlined),
              label: 'Study Groups',
            ),
            BottomNavigationBarItem(
              icon: viewModel.currentView == NavView.Profile
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  //* Private Methods
  Widget _getViewForView(NavView view) {
    switch (view) {
      case NavView.Events:
        return const EventsView();

      case NavView.StudyGroups:
        return const StudyGroupsView();

      case NavView.Profile:
        return const ProfileView();

      default:
        return const Placeholder();
    }
  }
}
