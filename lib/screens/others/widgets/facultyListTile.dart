import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../themes/my_theme.dart';
import '../../../utilities/myDialogBox.dart';

//Faculty listcard widget
class FacultyListTile extends StatefulWidget {
  //
  const FacultyListTile({
    Key? key,
    required this.name,
    required this.designation,
    required this.phone,
    required this.myEmail,
  }) : super(key: key);

  final String name;
  final String designation;
  final String phone;
  final String myEmail;

  @override
  State<FacultyListTile> createState() => _FacultyListTileState();
}

class _FacultyListTileState extends State<FacultyListTile> {
  bool isDark = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      isDark = await MyTheme.isDark();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    void showCallConfirmDialog() {
      MyDialogBox.confirmDialogBox(
        message: 'Hey, you wanna call ${widget.name}',
        noFun: () => Get.back(),
        noName: 'no',
        yesFun: () => FlutterPhoneDirectCaller.callNumber(widget.phone),
        yesName: 'call',
      );
    }

    void sendEmail() async {
      final Email email = Email(
        body: 'Hello sir,',
        subject: '',
        recipients: [widget.myEmail],
      );

      await FlutterEmailSender.send(email);
    }

    return Card(
      child: ExpansionTile(
        collapsedBackgroundColor: isDark
            ? const Color(0xFF001323).withAlpha(220)
            : Colors.grey.withAlpha(70),
        backgroundColor: isDark
            ? const Color(0xFF001323).withAlpha(220)
            : Colors.grey.withAlpha(70),
        childrenPadding: const EdgeInsets.all(0),
        title: Text(widget.name,
            style: kNormalSizeBoldTextStyle.copyWith(
              color: isDark ? Colors.white : Colors.black,
            )),
        subtitle: Text(
          'Dept: ${widget.designation}',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              'email:  ${widget.myEmail}',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            subtitle:
                Text('phone:  ${widget.phone}', style: kSmallSizeBoldTextStyle),
            trailing: SizedBox(
              width: 100,
              child: Row(children: [
                IconButton(
                  icon: const Icon(
                    Icons.phone_in_talk_rounded,
                    color: Colors.pink,
                  ),
                  onPressed: () => showCallConfirmDialog(),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.amber,
                  ),
                  onPressed: () => sendEmail(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
