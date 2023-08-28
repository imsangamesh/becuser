import 'package:becuser3/constants/constants.dart';
import 'package:becuser3/controllers/auth/google_auth_controller.dart';
import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final google = GoogleAuthController();
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: const Text('SignIn')),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('HEY THERE,  WELCOME TO '),
            Text(
              'BECUSER',
              style: kBigSizeBoldTextStyle.copyWith(shadows: [
                Shadow(
                  color: MyClr.apriClr,
                  blurRadius: 15,
                )
              ]),
            ),
            Image.asset('images/signinT.jpg'),
            ElevatedButton.icon(
              label: const Text(
                '   Signin with Google ',
                style: kNormalSizeTextStyle,
              ),
              icon: const Icon(Icons.account_circle),
              onPressed: () => google.signInWithGoogle(),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 10,
                  )),
            ),
            // const SizedBox(height: 10),
            // TextButton.icon(
            //   label: const Text(
            //     '  Signin anonymously  ',
            //     style: kSmallSizeBoldTextStyle,
            //   ),
            //   icon: const Icon(Icons.person_rounded),
            //   onPressed: () => GoogleAuthController.myAnonymousSignin(),
            //   style: TextButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       padding: const EdgeInsets.symmetric(
            //         vertical: 7,
            //         horizontal: 10,
            //       )),
            // ),
            // const SizedBox(height: 100),
          ],
        )),
      ),
    );
  }
}
// pending_actions_rounded
// perm_phone_msg_rounded