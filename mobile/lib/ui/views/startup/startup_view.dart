import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) async => await viewModel.runStartupLogic());

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Image.asset('assets/splash-screen.png'),
      ),
    );
  }
}
