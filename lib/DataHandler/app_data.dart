
import 'package:flutter/foundation.dart';
import 'package:uber_clone/Models/address.dart';

class AppData extends ChangeNotifier{
  Address? pickUpLocation;
  void updatePickUpLocationAddress(Address pickUpAddress){
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}