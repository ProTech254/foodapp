import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PickDate extends StatefulWidget {
  const PickDate({Key? key}) : super(key: key);

  @override
  _PickDateState createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a date"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_dateTime == null ? "Nothing has been selected" : _dateTime.toString()),
            RaisedButton(
                onPressed: (){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now() ,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2023),
                  ).then((date){
                    setState(() {
                      _dateTime = date;

                      _launchURL("https://www.opentable.com/s/?covers=2&dateTime=2019-02-25%2019%3A00&metroId=72&regionIds=5316&pinnedRids%5B0%5D=87967&enableSimpleCuisines=true&includeTicketedAvailability=true&pageType=0 ");
                    });
                  });
                },
              child: Text("Pick a Date", style: TextStyle(fontSize: 21),),
            )
          ],
        ),
      ),
    );
  }
  _launchURL(String url) async {
    // const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
