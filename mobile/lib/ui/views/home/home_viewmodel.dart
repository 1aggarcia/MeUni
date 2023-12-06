import 'package:stacked/stacked.dart';

enum NavView {
  events,
  studyGroups,
  profile,
}

class HomeViewModel extends IndexTrackingViewModel {
  //* Public Properties
  NavView get currentView => NavView.values[currentIndex];

  //* Constructors
  HomeViewModel(NavView? initialView) {
    if (initialView != null) {
      setIndex(initialView.index);
    }
  }
}
