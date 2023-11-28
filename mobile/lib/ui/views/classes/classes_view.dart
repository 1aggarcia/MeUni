import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'classes_viewmodel.dart';

import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'class'),
])
class ClassesView extends StackedView<ClassesViewModel> {
  const ClassesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ClassesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  ClassesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassesViewModel();
}
