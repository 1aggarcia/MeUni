import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/ui_helpers.dart';
import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'Username', validator: LoginValidators.validateUsername),
  FormTextField(name: 'Password', validator: LoginValidators.validatePassword),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    const labelTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    const errorTextStyle = TextStyle(
      color: Colors.red,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpaceMedium,

              // UserName
              const Text(
                'UserName',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              TextFormField(controller: usernameController),
              if (viewModel.hasUsernameValidationMessage) ...[
                verticalSpaceTiny,
                Text(
                  viewModel.usernameValidationMessage!,
                  style: errorTextStyle,
                ),
              ],

              verticalSpaceMedium,

              // Password
              const Text(
                'Password',
                style: labelTextStyle,
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              if (viewModel.hasPasswordValidationMessage) ...[
                verticalSpaceTiny,
                Text(
                  viewModel.passwordValidationMessage!,
                  style: errorTextStyle,
                ),
                verticalSpaceSmall,
              ],

              // Login Button
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
  void onViewModelReady(LoginViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
