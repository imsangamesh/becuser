import 'package:becuser3/controllers/auth/profile_controller.dart';
import 'package:becuser3/controllers/homeimgs_controller.dart';
import 'package:becuser3/screens/gallery/gallery.dart';
import 'package:becuser3/screens/home/mainDrawer.dart';
import 'package:becuser3/screens/home/pageButton.dart';
import 'package:becuser3/screens/json/pdf_converter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/noticeController.dart';
import '../questions_and_notes/path_selector.dart';
import '../questions_and_notes/widgets/my_all_viewers.dart';
import '../syllabus & timetable/syllabus_timetable.dart';
import 'widgets/noticeBoard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  final noticeCntr = Get.put(NoticeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MainDrawer(ProfileController.myInAppUm),
      appBar: AppBar(title: const Text('BECUSER')),
      body: RefreshIndicator(
        onRefresh: noticeCntr.fetchAndSetNoticeData,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            //Image Slider ---------------------------
            GetBuilder<HomeImageController>(builder: (homeImgCntr) {
              return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: size.height * 0.25,
                ),
                items: homeImgCntr.images
                    .map((image) => HomeImageTile(image))
                    .toList(),
              );
            }),
            const SizedBox(height: 20),
            // notice board ===========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<NoticeController>(
                builder: (notData) {
                  return NoticeBoard(
                    notData.noticeTitle,
                    notData.noticeBody,
                    notData.noticeDate,
                    notData.imageUrls,
                    notData.fileUrls,
                    notData.noticeLink,
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                PageButton(
                  title: 'Question Papers',
                  icon: Icons.library_books,
                  navigateTo: () => Get.to(
                    () => const PathSelector(SelectMode.questionPaper),
                  ),
                ),
                PageButton(
                  title: 'Notes',
                  icon: Icons.menu_book,
                  navigateTo: () => Get.to(
                    () => const PathSelector(SelectMode.note),
                  ),
                ),
                PageButton(
                  title: 'Gallery',
                  icon: Icons.collections,
                  navigateTo: () => Get.to(() => const Gallery()),
                ),
                PageButton(
                  title: 'My TimeTable',
                  icon: Icons.calendar_month,
                  navigateTo: () =>
                      SyllabusAndTimetable.downloadOrOpenFile('timetable'),
                ),
                PageButton(
                  title: 'Exam Blocks',
                  icon: Icons.person_search_rounded,
                  navigateTo: () => Get.to(
                    () => const PdfConverter(SearchMode.block),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeImageTile extends StatelessWidget {
  const HomeImageTile(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => MyFullScrNetImageViewer.showImagePopUp(context, imageUrl),
        child: Container(
          margin: const EdgeInsets.all(1.7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
