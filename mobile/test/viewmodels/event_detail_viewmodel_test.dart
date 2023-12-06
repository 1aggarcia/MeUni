import 'package:flutter_test/flutter_test.dart';
import 'package:meuni_mobile/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('EventDetailViewModel Tests -', () {
    setUp(registerServices);
    tearDown(locator.reset);
  });
}