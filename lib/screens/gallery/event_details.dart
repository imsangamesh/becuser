import 'package:becuser3/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  const EventDetails(this.eveData, {Key? key}) : super(key: key);

  final Map<String, dynamic> eveData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eveData['title'])),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Text(
            eveData['title'],
            textAlign: TextAlign.left,
            style: kPNormalSizeBoldTextStyle,
          ),
          const SizedBox(height: 5),
          Text(
            'Event date : ${DateFormat.yMMMMEEEEd().format(DateTime.parse(eveData['date'])).toString()}',
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            style: kSmallSizeBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Text(eveData['description'], style: kSmallSizeTextStyle),
          const SizedBox(height: 10),
          const Text('Memories :', style: kSmallSizeBoldTextStyle),
          ...(eveData['images'] as List<dynamic>)
              .map((e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(e),
                    ),
                  ))
              .toList(),
        ]),
      ),
    );
  }
}
