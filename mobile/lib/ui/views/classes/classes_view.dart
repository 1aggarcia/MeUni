import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';

import '../../widgets/loading_indicator.dart';
import '../../widgets/round_button.dart';
import 'classes_view.form.dart';
import 'classes_viewmodel.dart';

import 'dart:developer';


@FormView(fields: [
  FormTextField(
    name: 'prefix',
    validator: ClassValidators.validatePrefix,
  ),
  FormTextField(
    name: 'courseCode',
    validator: ClassValidators.validateCourseCode,
  ),
])


class ClassesView extends StackedView<ClassesViewModel> with $ClassesView {
  const ClassesView({Key? key}) : super(key: key);

  @override
  ClassesViewModel viewModelBuilder(
      BuildContext context
      ) =>
      ClassesViewModel();

  @override
  void onViewModelReady(ClassesViewModel viewModel) =>
      syncFormWithViewModel(viewModel);

  @override
  Widget builder(
    BuildContext context,
    ClassesViewModel viewModel,
    Widget? child,
  ) {

    const List<String> prefixes = ['ARCTIC', 'HONORS', 'LEAD', 'ACADEM',
      'AFRAM', 'AES', 'AAS', 'CHSTU', 'SWA', 'TAGLG',
      'AIS', 'ANTH', 'ARCHY', 'BIO A', 'AMATH', 'CFRM',
      'ART', 'ART H', 'DESIGN', 'ARTSCI', 'ARTS', 'ASIAN',
      'BENG', 'CHIN', 'HINDI', 'INDN', 'INDO', 'JAPAN',
      'KOREAN', 'SNKRT', 'S ASIA', 'URDU', 'VIET', 'ASTR',
      'ASTBIO', 'BIOL', 'BIOL', 'CS&SS', 'CSDE', 'HUM',
      'CHEM', 'CMS', 'C LIT', 'CL AR', 'CL LI', 'CLAS',
      'GREEK', 'LATIN', 'COM', 'COMMLD', 'CHID', 'RELIG',
      'DANCE', 'DXARTS', 'DIS ST', 'DRAMA', 'ECON', 'ENGL',
      'FRENCH', 'ITAL', 'TXTDS', 'GWSS', 'GEN ST', 'GIS',
      'INDIV', 'GEOG', 'GERMAN', 'JSIS E', 'HSTAM', 'HSTCMP',
      'HSTAFM', 'HSTAS', 'HSTLAC', 'HSTEU', 'HSTAA', 'HSTRY',
      'HUM', 'INTSCI', 'RELIG', 'JSIS', 'JSIS A', 'JSIS B',
      'JSIS C', 'JSIS D', 'JSIS E', 'JEW ST', 'LABOR', 'LSJ',
      'ASL', 'LING', 'LIT', 'MATH', 'ARAB', 'ARAMIC', 'COPTIC',
      'EGYPT', 'GEEZ', 'HEBR', 'BIBHEB', 'MODHEB', 'NEAR E',
      'PRSAN', 'TURKIC', 'CHGTAI', 'KAZAKH', 'KYRGYZ', 'UYGUR',
      'UZBEK', 'TKISH', 'UGARIT', 'MUSIC', 'MUSAP', 'MUSED',
      'MUSEN', 'MUHST', 'MUSICP', 'NBIO', 'NEUSCI', 'ETHICS',
      'HPS', 'PHIL', 'PHYS', 'POL S', 'PSYCAP', 'PSYCLN', 'PSYCH',
      'DANISH', 'ESTO', 'FINN', 'ICEL', 'LATV', 'LITH', 'NORW',
      'SCAND', 'SWED', 'BCMS', 'BULGR', 'CZECH', 'GEORG', 'GLITS',
      'POLSH', 'ROMN', 'RUSS', 'SLAVIC', 'SLVN', 'UKR', 'SOCSCI',
      'SOC', 'PORT', 'SPAN', 'SPLING', 'SPHSC', 'STAT', 'BIOL',
      'ARCH', 'B E', 'CM', 'L ARCH', 'R E', 'CEP', 'IPM', 'URBDP',
      'ACCTG', 'ADMIN', 'B A', 'BA RM', 'BUS AN', 'B CMU', 'B ECON',
      'B POL', 'EBIZ', 'ENTRE', 'FIN', 'HRMOB', 'I S', 'MSIS',
      'I BUS', 'MGMT', 'MKTG', 'OPMGT', 'O E', 'QMETH', 'ST MGT',
      'SCM', 'DENTCL', 'DENTEL', 'DENTFN', 'DENTGP', 'D HYG',
      'DENTPC', 'DENTSL', 'DPHS', 'DENT', 'ENDO', 'ORALB', 'OHS',
      'ORALM', 'O S', 'ORTHO', 'PEDO', 'PERIO', 'PROS', 'RES D',
      'EDC&I', 'EDUC', 'ECE', 'ECFS', 'EDTEP', 'EDLPS', 'EDPSY',
      'EDSPE', 'A A', 'A E', 'CHEM E', 'NME', 'CEE', 'CESI', 'CEWA',
      'CESG', 'CET', 'CSE', 'CSE D', 'E E', 'ENGR', 'HCDE', 'IND E',
      'MS E', 'M E', 'MEIE', 'FISH', 'ATM S', 'C ENV', 'SCI T',
      'ESS', 'ENVIR', 'BSE', 'ESRM', 'SEFS', 'FHL', 'SMEA',
      'MARBIO', 'OCEAN', 'Q SCI', 'QERM', 'QUAT', 'INFO', 'INSC',
      'IMT', 'LIS', 'BPSD', 'DATA', 'GRDSCH', 'HCID', 'HDD', 'IPHD',
      'MCB', 'MOLENG', 'MUSEUM', 'N&MES', 'NEURO', 'PUBSCH', 'STSS',
      'TECHIN', 'BIOEN', 'MEDENG', 'PHARBE', 'G H', 'UCONJ', 'LAW',
      'LAW A', 'LAW B', 'LAW C', 'LAW E', 'LAW H', 'LAW P', 'LAW T',
      'ANEST', 'BIOC', 'B H', 'B STR', 'BIME', 'C MED', 'CONJ',
      'FAMED', 'MEDLIC', 'GENOME', 'HMS', 'HUBIO', 'IMMUN', 'LAB M',
      'PATH', 'MEDSCI', 'MED EM', 'GCNSL', 'MED', 'MEDECK',
      'MEDRCK', 'MICROM', 'MOLMED', 'NEUR S', 'NEURL', 'OB GYN',
      'OPHTH', 'ORTHP', 'OTOHN', 'PEDS', 'PHCOL', 'P BIO', 'PBSCI',
      'R ONC', 'RADGY', 'RHB PO', 'REHAB', 'SURG', 'UROL', 'IECMH',
      'NSG', 'NURS', 'NCLIN', 'NMETH', 'HEOR', 'MEDCH', 'PCEUT',
      'PHARM', 'PHRMCY', 'PHARMP', 'PHRMPR', 'PHRMRA', 'PUBPOL',
      'PPM', 'BIOST', 'ENV H', 'EPI', 'HIHIM', 'HSERV', 'HSMGMT',
      'NUTR', 'PABIO', 'PHG', 'PHI', 'SPH', 'A S', 'M SCI', 'N SCI',
      'SOC WF', 'SOC WL','SOC W'];

    String _dropDownValue = ''; // add one value as the defaul one which must exists in the dropdown value

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Class'),
          backgroundColor: kcPrimaryColor,
          foregroundColor: kcSecondaryColor,
        ),
        backgroundColor: kcBackgroundColor,
        body: viewModel.isBusy
            ? LoadingIndicator(loadingText: 'Adding Class')
            : Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                DropdownButtonFormField(
                  decoration:
                      const InputDecoration(labelText: 'Course Prefix'),
                  items: prefixes.map((prefixVal) => DropdownMenuItem(
                    value: prefixVal,
                    child: Text(prefixVal)
                  )).toList(),
                  onChanged: (value) {
                      _dropDownValue = value!;
                      prefixController.text = value!;
                      viewModel.setPrefix(value);
                      log('data: $prefixController.text');
                  },
                  value: viewModel.prefixVal.isNotEmpty ? viewModel.prefixVal : null, // this place should not have a controller but a variable
                ),
                TextFormField(
                  controller: courseCodeController,
                  decoration:
                    const InputDecoration(labelText: 'Course Code'),
                ),
                RoundButton(
                  label: 'Add Class',
                  // onPressed: () async => await ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
