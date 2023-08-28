import 'dart:developer';

import 'package:becuser3/controllers/storage/pdf_controller.dart';
import 'package:becuser3/utilities/myDialogBox.dart';
import 'package:becuser3/utilities/my_buttons.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../themes/my_colors.dart';
import '../questions_and_notes/widgets/my_drop_down_dgnr.dart';
import 'widgets/block_details.dart';

enum SearchMode { result, block }

class PdfConverter extends StatefulWidget {
  const PdfConverter(this.searchMode, {Key? key}) : super(key: key);

  final SearchMode searchMode;

  @override
  State<PdfConverter> createState() => _PdfConverterState();
}

class _PdfConverterState extends State<PdfConverter> {
  //
  final usnCntr = TextEditingController();
  List<dynamic> semesters = [];
  dynamic currSem = '';
  bool isLoading = true;
  List json = [];
  bool showBlockData = false;
  var mapData = {};

  fetchSemData() async {
    semesters = await PDFController.fetchAndSetSemesters(
      widget.searchMode == SearchMode.result ? 'examresults' : 'block',
    );
    currSem = semesters[0];
    setState(() => isLoading = false);
  }

  fetchResData() async {
    json = await PDFController.fetchResultData(
      widget.searchMode == SearchMode.result ? 'examresults' : 'block',
      currSem,
    );
    setState(() {});
  }

  @override
  void initState() {
    fetchSemData();
    Future.delayed(const Duration(seconds: 3)).then((value) => fetchResData());
    super.initState();
  }
//                     2BA20CS557    2BA20CV080

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$modeConfigurer Viewer')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(40),
              child: ListView(
                children: [
                  // ----------------------------- dropdown
                  MyDropDownDgnr(
                    'Select Semester',
                    DropdownButton(
                      dropdownColor: MyClr.priClr100,
                      underline: MyDropDownDgnr.transparentDivider,
                      isExpanded: true,
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      value: currSem,
                      items: semesters
                          .map((items) => DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() => currSem = newValue);
                        fetchResData();
                      },
                    ),
                  ),
                  // ----------------------------- textfield
                  TextField(
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'enter your usn',
                      prefixIcon: Icon(Icons.search),
                    ),
                    controller: usnCntr,
                  ),
                  MyElevButton('Search', () {
                    FocusScope.of(context).unfocus();
                    convertAndOpenFile();
                  }),
                  if (widget.searchMode == SearchMode.block && showBlockData)
                    Column(children: blockDetails(mapData)),
                  if (widget.searchMode == SearchMode.result && showBlockData)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mapData.keys
                            .map(
                              (each) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  '${each.toString().toUpperCase()}  :  ${each == 'withheld' ? mapData[each] == 0 ? 'no' : 'yes' : mapData[each]}',
                                  style: kSmallSizeTextStyle,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  String get modeConfigurer {
    if (widget.searchMode == SearchMode.result) return 'Result';
    if (widget.searchMode == SearchMode.block) return 'Block';
    return '';
  }

  convertAndOpenFile() async {
    String usn = usnCntr.text.trim().toUpperCase();
    if (usn.length != 10) {
      MyDialogBox.showSnackBar('please enter a valid USN');
      return;
    }

    final resMap =
        json.firstWhere((element) => element['usn'] == usn, orElse: () {
      usn = '-1';
      return {};
    });

    if (usn == '-1') {
      MyDialogBox.showSnackBar('didn\'t find related Results',
          yes: false, time: 2000);
      return;
    }
    if (resMap['withheld'] == 1) {
      MyDialogBox.defaultDialog(
        'Alert !',
        'your Results are with held, please reach out college Admission section for further notice.',
      );
      setState(() => mapData = {});
      return;
    }
    // if (widget.searchMode == SearchMode.result) {
    //   final File pdf = await PDFController.generate(resMap);
    //   await OpenFile.open(pdf.path);
    // } else if (widget.searchMode == SearchMode.block) {
    mapData =
        json.where((element) => element['usn'] == usnCntr.text).toList()[0];

    log(mapData.toString());
    setState(() => showBlockData = true);
    // }
  }
}
