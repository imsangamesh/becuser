import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/screens/questions_and_notes/questions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/data.dart';
import '../../constants/constants.dart';
import 'notes.dart';
import 'widgets/my_drop_down_dgnr.dart';

enum SelectMode { questionPaper, note }

class PathSelector extends StatefulWidget {
  const PathSelector(
    this.mode, {
    Key? key,
  }) : super(key: key);

  final SelectMode mode;

  @override
  State<PathSelector> createState() => _PathSelectorState();
}

class _PathSelectorState extends State<PathSelector> {
  //

  void _submitForm() {
    // ========== question papers
    if (widget.mode == SelectMode.questionPaper) {
      final path = '$currDept~$currSem~$currSub';
      Get.to(() => QuestionPapers(path));
    }
    // ========== notes
    else if (widget.mode == SelectMode.note) {
      final path = '$currDept~$currSem~$currSub';
      Get.to(() => Notes(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.mode == SelectMode.questionPaper
              ? 'Select Question Papers'
              : 'Select Notes')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------------------------------department---------------

              MyDropDownDgnr(
                'Select Department',
                DropdownButton(
                  dropdownColor: MyClr.priClr100,
                  underline: MyDropDownDgnr.transparentDivider,
                  isExpanded: true,
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  ////////////////
                  value: currDept,
                  items: departments
                      .map((String items) => DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => currDept = newValue!);
                    selectDepartment(newValue!);
                  },
                ),
              ),
              // ---------------------------------semester---------------
              MyDropDownDgnr(
                'Select Semester',
                DropdownButton(
                  dropdownColor: MyClr.priClr100,
                  underline: MyDropDownDgnr.transparentDivider,
                  isExpanded: true,
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  ////////////////
                  value: currSem,
                  items: semesters
                      .map((String items) => DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => currSem = newValue!);
                    selectSemester(newValue);
                  },
                ),
              ),

              // ---------------------------------subject---------------
              MyDropDownDgnr(
                'Select Subject',
                DropdownButton(
                  dropdownColor: MyClr.priClr100,
                  underline: MyDropDownDgnr.transparentDivider,
                  isExpanded: true,
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  ////////////////
                  value: currSub,
                  items: subjects
                      .map((String items) => DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      currSub = newValue!;
                    });
                  },
                ),
              ),

              // --------------------------------- submit ---------------
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Search', style: kNormalSizeBoldTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> departments = departMapData.keys.toList();
  String currDept = departMapData.keys.toList()[0];

  List<String> semesters = departMapData['Civil Engineering']!.keys.toList();
  String currSem = departMapData['Civil Engineering']!.keys.toList()[0];

  List<String> subjects =
      departMapData['Civil Engineering']!['P cycle']!.keys.toList();
  String currSub =
      departMapData['Civil Engineering']!['P cycle']!.keys.toList()[0];

  void selectDepartment(String selDep) {
    setState(() {
      currSem = departMapData[selDep]!.keys.toList()[0];
      currSub = departMapData[selDep]![semesters[0]]!.keys.toList()[0];
      //
      semesters = departMapData[selDep]!.keys.toList();
      subjects = departMapData[selDep]![semesters[0]]!.keys.toList();
      //
    });
  }

  void selectSemester(selSem) {
    setState(() {
      currSub = departMapData[currDept]![selSem]!.keys.toList()[0];
      //
      subjects = departMapData[currDept]![selSem]!.keys.toList();
    });
  }
}
