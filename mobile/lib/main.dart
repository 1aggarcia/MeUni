import 'package:flutter/material.dart';
import 'package:meuni_mobile/app/app.bottomsheets.dart';
import 'package:meuni_mobile/app/app.dialogs.dart';
import 'package:meuni_mobile/app/app.locator.dart';
import 'package:meuni_mobile/app/app.router.dart';
import 'package:meuni_mobile/ui/views/startup/slashScreen.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Set the SplashScreen as the home
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
