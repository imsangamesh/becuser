import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/helpers/myHelper.dart';
import 'package:becuser3/models/userModel.dart';
import 'package:becuser3/screens/auth/profile_fill_up_screen.dart';
import 'package:becuser3/screens/extras/developer.dart';
import 'package:becuser3/screens/gallery/gallery.dart';
import 'package:becuser3/screens/others/faculty.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:becuser3/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../json/pdf_converter.dart';
import '../questions_and_notes/path_selector.dart';
import '../syllabus & timetable/syllabus_timetable.dart';
import 'widgets/myDrawerListTile.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer(this.um, {Key? key}) : super(key: key);

  final UserModel um;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final userProfileUrl = auth.currentUser!.photoURL;

  String get usernameBuilder {
    return widget.um.name == null
        ? 'hello world'
        : widget.um.name!.length > 30
            ? widget.um.name!.substring(0, 30)
            : widget.um.name!;
  }

  String get detailsBuilder {
    return '${MyHelper.giveMyDepartmentShort(widget.um.department!)}      ${MyHelper.giveMySemShort(widget.um.semester!)} ';
  }

  bool isDark = false;

  setIsDarkTheme() async {
    isDark = await MyTheme.isDark();
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => setIsDarkTheme());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: SizedBox(
        height: size.height,
        child: Column(
          children: [
            AppBar(
              title: const Text('BECUSER'),
              leading: IconButton(
                icon: const Icon(Icons.chevron_left_sharp, size: 30),
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => Get.to(() => ProfileFillUpScreen(widget.um)),
              splashColor: MyClr.priClr100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: MyClr.priClr100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(widget.um.profilepic!),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usernameBuilder,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: kNormalSizeBoldTextStyle,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            detailsBuilder,
                            style: kSmallSizeTextStyle.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    MyDrawerListTile(
                      title: 'Question Papers',
                      icon: Icons.library_books,
                      navigateTo: () => Get.to(
                        () => const PathSelector(SelectMode.questionPaper),
                      ),
                    ),
                    MyDrawerListTile(
                      title: 'Notes',
                      icon: Icons.menu_book,
                      navigateTo: () => Get.to(
                        () => const PathSelector(SelectMode.note),
                      ),
                    ),
                    MyDrawerListTile(
                      title: 'Gallery',
                      icon: Icons.collections,
                      navigateTo: () => Get.to(const Gallery()),
                    ),
                    MyDrawerListTile(
                      title: 'My Syllabus',
                      icon: Icons.notes,
                      navigateTo: () =>
                          SyllabusAndTimetable.downloadOrOpenFile('syllabus'),
                    ),
                    MyDrawerListTile(
                      title: 'My TimeTable',
                      icon: Icons.calendar_month,
                      navigateTo: () =>
                          SyllabusAndTimetable.downloadOrOpenFile('timetable'),
                    ),
                    MyDrawerListTile(
                      title: 'College Faculty',
                      icon: Icons.contacts,
                      navigateTo: () => Get.to(const Faculty()),
                    ),
                    MyDrawerListTile(
                      title: 'Results',
                      icon: Icons.manage_search_outlined,
                      navigateTo: () =>
                          Get.to(() => const PdfConverter(SearchMode.result)),
                    ),
                    ExpansionTile(
                      collapsedIconColor: MyClr.apriClr,
                      childrenPadding: const EdgeInsets.only(bottom: 5),
                      leading: const Icon(Icons.color_lens, size: 33),
                      title: Text(
                        'Themes',
                        style: kNormalSizeTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            ...MyClr.listOfOtherThemes.map(
                              (each) {
                                return InkWell(
                                  onTap: () => MyClr.setColor(each, false),
                                  splashColor: MyClr.apriClr,
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          MyClr.myColorsToMaterial(each),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            Container(
                              margin: const EdgeInsets.only(top: 5, left: 5),
                              height: 41,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Switch(
                                  value: isDark,
                                  onChanged: (val) => setState(() {
                                    MyClr.setColor(MyColors.blue, true);
                                    isDark = val;
                                  }),
                                ),
                                label: const Text(
                                  'Dark Theme   ',
                                  style: kSmallSizeBoldTextStyle,
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: MyClr.apriClr,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  side: BorderSide(
                                    color: MyClr.priClr100,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const DeveloperContact(),
          ],
        ),
      ),
    );
  }
}
