import 'package:becuser3/screens/home/homeScreen.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/google_auth_controller.dart';
import '../../controllers/auth/profile_controller.dart';
import '../../helpers/data.dart';
import '../../utilities/myDialogBox.dart';
import '../questions_and_notes/widgets/my_drop_down_dgnr.dart';
import 'signInScreen.dart';

class ProfileFillUpScreen extends StatefulWidget {
  const ProfileFillUpScreen(
    this.um, {
    Key? key,
  }) : super(key: key);

  final UserModel um;

  @override
  State<ProfileFillUpScreen> createState() => _ProfileFillUpScreenState();
}

class _ProfileFillUpScreenState extends State<ProfileFillUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool settingDataOver = false;

  void _saveForm() {
    if (_nameController.text.trim() == '') {
      MyDialogBox.showSnackBar('Please provide a Name', time: 2000, yes: false);
      return;
    }

    uploadUserData();
  }

  void uploadUserData() async {
    if (widget.um.name == _nameController.text.trim() &&
        widget.um.department == currDept &&
        widget.um.semester == currSem) {
      Get.offAll(() => const HomeScreen());
      return;
    } else {
      ProfileController.uploadUserDataAndComplete(
        widget.um.uid!,
        _nameController.text,
        widget.um.profilepic!,
        widget.um.email!,
        widget.um.phone!,
        currSem,
        currDept,
      );
    }
  }

  void fetchUserData() async {
    if (widget.um.isprofilecomplete) {
      _nameController.text = widget.um.name!;
      currDept = widget.um.department!;
      currSem = widget.um.semester!;
      setState(() => settingDataOver = true);
    }
  }

  void confirmLogout() {
    MyDialogBox.confirmDialogBox(
      message: 'You will be LoggedOut. Do you really want to LogOut?',
      noFun: () => Get.back(),
      noName: 'No',
      yesFun: () async {
        GoogleAuthController.mySignOut();
        Get.offAll(const SigninScreen());
      },
      yesName: 'Yes',
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => fetchUserData());
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ----------------logout----------------------
                if (widget.um.isprofilecomplete)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.power_settings_new_rounded,
                          size: 32,
                        ),
                        onPressed: confirmLogout,
                      )
                    ],
                  ),
                const SizedBox(height: 30),
                // ---------------- profile ----------------------
                CircleAvatar(
                  radius: 70,
                  backgroundColor: MyClr.priClr100,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: MyClr.apriClr,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        widget.um.profilepic!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // ----------------name----------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Your Name :',
                      prefixIcon: Icon(Icons.edit_note_sharp),
                    ),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 10),
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
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  // ----------------elevated button----------------------
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _saveForm();
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> departments = departMapData.keys.toList();
  String currDept = departMapData.keys.toList()[0];

  List<String> semesters = departMapData['Civil Engineering']!.keys.toList();
  String currSem = departMapData['Civil Engineering']!.keys.toList()[0];

  void selectDepartment(String selDep) {
    setState(() {
      currSem = departMapData[selDep]!.keys.toList()[0];
      semesters = departMapData[selDep]!.keys.toList();
    });
  }
}

// final listofsemester = [
//   'P Cycle',
//   'C Cycle',
//   '3 - Semester',
//   '4 - Semester',
//   '5 - Semester',
//   '6 - Semester',
//   '7 - Semester',
//   '8 - Semester',
// ];