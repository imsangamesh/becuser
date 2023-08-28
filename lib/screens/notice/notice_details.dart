import 'package:becuser3/utilities/myDialogBox.dart';
import 'package:becuser3/utilities/my_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/link.dart';

import '../../constants/constants.dart';
import '../questions_and_notes/widgets/my_all_viewers.dart';

class NoticeDetailsScreen extends StatelessWidget {
  const NoticeDetailsScreen(this.title, this.body, this.date, this.imageUrls,
      this.fileUrls, this.link,
      {Key? key})
      : super(key: key);

  final String title, body, date, link;
  final List imageUrls, fileUrls;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest Notice')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------- title & date
              Text(title, style: kNormalSizeBoldTextStyle),
              const SizedBox(height: 5),
              Text(' $date', style: kGSmallSizeBoldTextStyle),
              const SizedBox(height: 20),
              // -------------------------- body
              Text(body, style: kSmallSizeTextStyle.copyWith(wordSpacing: 5)),
              const SizedBox(height: 20),
              // -------------------------- link
              if (link != '')
                Row(
                  children: [
                    const Text(
                      'Attached link :',
                      style: kNormalSizeTextStyle,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: link));
                        MyDialogBox.showSnackBar('Link copied to clipboard !');
                      },
                      child: const Text(
                        'Copy link',
                        style: kSmallSizeBoldTextStyle,
                      ),
                    )
                  ],
                ),
              const SizedBox(height: 2),
              Link(
                uri: Uri.parse(link),
                builder: (context, openLink) {
                  return InkWell(
                    splashColor: Colors.blue.withAlpha(100),
                    child: Text(
                      link,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: openLink,
                  );
                },
              ),
              const SizedBox(height: 20),
              // -------------------------- images
              if (imageUrls.isNotEmpty) ...[
                Text(
                  '${imageUrls.length} attached images :',
                  style: kNormalSizeTextStyle,
                ),
                const SizedBox(height: 2),
                Wrap(
                  children: imageUrls
                      .map((echUrl) => MyNetImageViewer(echUrl))
                      .toList(),
                ),
              ],
              // -------------------------- files
              if (fileUrls.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  ' ${fileUrls.length} attached files :',
                  style: kNormalSizeTextStyle,
                ),
                Wrap(
                  children: fileUrls
                      .map((echUrl) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: MyOutLButton(
                              'Open File',
                              () => Get.to(
                                () => MyNetFileViewer(echUrl, 'Attached file'),
                              ),
                              textStyle: kSmallSizeBoldTextStyle,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
