import 'package:flutter/material.dart';
import 'package:meuni_mobile/ui/views/events/events_view.dart';
import 'package:meuni_mobile/ui/views/profile/profile_view.dart';
import 'package:meuni_mobile/ui/views/study_groups/study_groups_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: _getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFB5A8A0),
        currentIndex: viewModel.currentIndex,
        selectedItemColor: Colors.orange[700],
        unselectedItemColor: const Color(0xFF00004D),
        onTap: viewModel.setIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Study Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const EventsView();
      case 1:
        return const StudyGroupsView();
      case 2:
        return const ProfileView();
    }

    return const Placeholder();
  }
}
