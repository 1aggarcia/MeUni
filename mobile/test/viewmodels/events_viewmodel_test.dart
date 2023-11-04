import 'package:flutter_test/flutter_test.dart';
import 'package:meuni_mobile/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('EventsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });

  group('incrementCounter -', () {
    test('Helloworld Test', () {
      expect(true, true);
    });
  });
}
