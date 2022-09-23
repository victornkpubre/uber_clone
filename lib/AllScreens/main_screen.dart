import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/AllScreens/search_screen.dart';
import 'package:uber_clone/AllWidgets/divider_widget.dart';
import 'package:uber_clone/Assistants/assistantMethod.dart';
import 'package:uber_clone/DataHandler/app_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Completer<GoogleMapController> _mapControllerCompleter = Completer();
  late GoogleMapController googleMapController; 

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>(); 

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition( ) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latlngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlngPosition, zoom: 14);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address ::" + address);
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796, -122.085),
    zoom: 14.5
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(title: Text("Home Page")),
      drawer: Container(
        color: Colors.white,
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65, width: 65),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(fontSize: 16, fontFamily: "Brand-Bold")),
                          SizedBox(height: 6),
                          Text("Visit Profile")
                        ],
                      ) 
                    ],
                  ),
                ),
              ),

              Divider(),

              SizedBox(height: 12,),
              
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History", style: TextStyle(fontSize: 15)),
              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit Profile", style: TextStyle(fontSize: 15)),
              ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text("About", style: TextStyle(fontSize: 15)),
              ),

            ],
          ),
        ),
      ),
      body: Stack(
        children: [

          Container(
            padding: EdgeInsets.only(bottom: 245),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller){
                _mapControllerCompleter.complete(controller);
                googleMapController = controller;
                setState(() {
                  bottomPaddingOfMap = 265;
                });
                locatePosition();
              },
            ),
          ),

          //Hamburger Button
          Positioned(
            top: 45,
            left: 22,
            child: GestureDetector(
              onTap: (){
                scaffoldkey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu),
                  radius: 20,
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 245,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7)
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 6,),
                  Text("Hi There, ", style: TextStyle(fontSize: 12)),
                  Text("Where to? ", style: TextStyle(fontSize: 20, fontFamily: "Brand-Bold")),
                  
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7)
                        )
                      ]
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(SearchScreen.idScreen, (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: const [
                            Icon(Icons.search, color: Colors.yellowAccent),
                            SizedBox(width: 10),
                            Text("Search Drop Off")
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.grey),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Provider.of<AppData>(context).pickUpLocation != null?
                            Provider.of<AppData>(context).pickUpLocation!.placeName
                            :"Add Home"
                          ),
                          SizedBox(height: 4,),
                          Text("Your living home address", style: TextStyle(color: Colors.black54, fontSize: 12),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),

                  const DividerWidget(),
                  
                  Row(
                    children: [
                      const Icon(Icons.work, color: Colors.grey),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Add Work"),
                          SizedBox(height: 4),
                          Text("Your office address", style: TextStyle(color: Colors.black54, fontSize: 12))
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
          )

        ]
      ),
    );
  }
}