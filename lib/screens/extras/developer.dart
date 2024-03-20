import 'package:becuser3/themes/my_colors.dart';
import 'package:flutter/material.dart';

class DeveloperContact extends StatelessWidget {
  const DeveloperContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyClr.priClr100,
      width: double.infinity,
      child: const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'developed by:',
                textAlign: TextAlign.center,
              ),
              Text(
                'Sangamesh Kyatappanavar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              Text(
                'managed by:',
                textAlign: TextAlign.center,
              ),
              Text(
                'Sudeep Sajjan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
