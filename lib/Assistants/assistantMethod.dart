
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/Assistants/requestAssistant.dart';
import 'package:uber_clone/DataHandler/app_data.dart';
import 'package:uber_clone/Models/address.dart';
import 'package:uber_clone/config.dart';

class AssistantMethods {
  
  
  static Future<String> searchCoordinateAddress(Position position, BuildContext context) async {
    String st1,st2,st3,st4;
    String placeAddress = '';
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(url);
    
    if(response != "failed"){
      // placeAddress = response["results"][0]["formatted_address"];
      st1 = response["result"][0]["address_components"][0]["long_name"];
      st2 = response["result"][0]["address_components"][1]["long_name"];
      st3 = response["result"][0]["address_components"][5]["long_name"];
      st4 = response["result"][0]["address_components"][6]["long_name"];
      placeAddress = st1+", "+st2+", "+st3+", "+st4;

      Address userPickUpAddress = Address(
        placeName: placeAddress,
        latitude: position.latitude,
        longitude: position.longitude
      );

      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);

    }

    return placeAddress;
  }





}