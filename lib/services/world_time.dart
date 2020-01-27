import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url;   // location url for api endpoint
  bool isDaytime; // true if daytime else false

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    
    // make a network request for data for a username
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      // print(datetime);
      // print(offset);
      
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print(now);

      isDaytime = (now.hour > 6) && (now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
// Set the time property
  }




}