import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'login_view.form.dart';
import '../../common/ui_helpers.dart';


import 'login_viewmodel.dart';

import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'Username'),
  FormTextField(name: 'Password'),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context,
      LoginViewModel viewModel,
      Widget? child,
      ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,
              const Text(
                'UserName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              verticalSpaceSmall,
              TextFormField(controller: usernameController),
              if (viewModel.hasUsernameValidationMessage) ...[
                verticalSpaceTiny,
                Text(
                  viewModel.usernameValidationMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              verticalSpaceMedium,
              const Text(
                'Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              verticalSpaceSmall,
              TextFormField(controller: passwordController, obscureText: true),
              if (viewModel.hasPasswordValidationMessage) ...[
                verticalSpaceTiny,
                Text(
                  viewModel.passwordValidationMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpaceSmall,
              ],
              MaterialButton(
                color: Colors.black,
                onPressed: () async => await viewModel.loginUser(),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
