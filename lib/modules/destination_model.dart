import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DestinationModel with ChangeNotifier {


  String? _name ;

  String ?get getname => _name;

  void setname(String value) {
    _name = value;
    notifyListeners();
  }

  double _latitude = 0;

  double get getLatitude => _latitude;

  void setLatitude(double value) {
    _latitude = value;
    notifyListeners();
  }

  double _longitude = 0;

  double get getLongitude => _longitude;

  void setLongitude(double value) {
    _longitude = value;
    notifyListeners();
  }

  //fetch dtat destination from json
  Future loadDestinationPlaces(BuildContext context) async {
    var url = Uri.parse(
        'https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json');

    http.Response response = await http.get(url);

    dynamic responseDecoded = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        print(responseDecoded);

        return responseDecoded;
      } catch (e) {
        throw responseDecoded["message"];
      }
    } else {
      print("error");
    }
    notifyListeners();
  }
}
