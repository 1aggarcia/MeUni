import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_event_viewmodel.dart';

class CreateEventView extends StackedView<CreateEventViewModel> {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateEventViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: [
            MaterialButton(
              color: Colors.black,
              onPressed: () => viewModel.goToPrevPage(),
              child: const Text(
                'Go Back',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Placeholder(),
          ],
        ),
      ),
    );
  }

  @override
  CreateEventViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateEventViewModel();
}
