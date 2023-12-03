import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../events/events_view.dart';
import '../profile/profile_view.dart';
import '../study_groups/study_groups_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  //* Overridden Methods
  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

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
        body: _getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kcMediumGrey,
          currentIndex: viewModel.currentIndex,
          selectedItemColor: kcTextAccentColor,
          unselectedItemColor: kcPrimaryColor,
          onTap: viewModel.setIndex,
          items: [
            BottomNavigationBarItem(
              icon: viewModel.currentIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: viewModel.currentIndex == 1
                  ? const Icon(Icons.book)
                  : const Icon(Icons.book_outlined),
              label: 'Study Groups',
            ),
            BottomNavigationBarItem(
              icon: viewModel.currentIndex == 2
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
  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const EventsView();

      case 1:
        return const StudyGroupsView();

      case 2:
        return const ProfileView();

      default:
        return const Placeholder();
    }
  }
}
