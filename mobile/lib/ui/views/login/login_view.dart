import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/loading_indicator.dart';
import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  //* Overridden Methods
  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MeUni',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kcTextAccentColor,
                  fontSize: 96,
                  fontFamily: 'Cupertino',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'All Kind of Friendship',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF614545),
                  fontSize: 21,
                  fontFamily: 'Libre Baskerville',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              verticalSpaceMassive,
              viewModel.isBusy
                  ? const LoadingIndicator(
                      loadingText: 'Logging in',
                    )
                  : GoogleAuthButton(
                      onPressed: viewModel.signInWithGoogleAsync,
                      style: const AuthButtonStyle(
                        buttonColor: Color(0xff428554),
                        iconSize: 24,
                        iconBackground: Colors.white,
                        buttonType: AuthButtonType.secondary,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
