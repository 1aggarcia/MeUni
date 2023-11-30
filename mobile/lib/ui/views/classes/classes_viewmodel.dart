import 'package:stacked/stacked.dart';

import 'classes_view.form.dart';

class ClassesViewModel extends FormViewModel {
  String prefixVal = '';

  String? setPrefix(String? value) {
    if (value == null) {
      return null;
    }
    prefixValue = value;
    rebuildUi();
  }

}

class ClassValidators {
  //* Public Methods
  static String? validatePrefix(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Prefix Cannot be Empty';
    }

    // check if prefix is in course list

  }

  static String? validateCourseCode(String? value) {
    if (value == null) {
      return null;
    }

    int? courseCode = int.tryParse(value);

    if (courseCode == null) {
      return 'Only numbers allowed';
    } else if (courseCode < 100 || courseCode > 699) {
      return 'courseCode must be from 100-699';
    }
  }

}
