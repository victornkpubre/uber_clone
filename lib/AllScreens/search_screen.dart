
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/Assistants/requestAssistant.dart';
import 'package:uber_clone/DataHandler/app_data.dart';
import 'package:uber_clone/config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  static const String idScreen = "searchScreen" ;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation != null? Provider.of<AppData>(context).pickUpLocation!.placeName: "";
    pickUpTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [

                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7)
                )

              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                        child: Text("Set Drop Off", style: TextStyle(fontSize: 18, fontFamily: "Brand-Bold")),
                      ),
                    ],
                  ),


                  SizedBox(height: 16,),
                  Row(
                    children: [
                      
                      Image.asset("images/pickicon.png", height: 16, width: 16,),
                      
                      SizedBox(width: 18),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                              hintText: "PickUp Location",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11, top: 8, bottom:8)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 16),
                  Row(
                    children: [
                      
                      Image.asset("images/desticon.png", height: 16, width: 16,),
                      
                      const SizedBox(width: 18),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: TextField(
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Where to?",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 11, top: 8, bottom: 8)
                            ),
                          ),
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          )  
        ],
      ),
    );
  }

  Future<void> findPlace(String placeName) async {
    if(placeName.length>1){
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=12345678910&components=country:pk";
      var res = await RequestAssistant.getRequest(autoCompleteUrl);
      if(res == "failed"){
        return;
      }

      if(res["status"  == "OK"]){
        var predicitions = res["predictions"]; 
      }

      // print("Places Prediction Response :: ");
      // print(res);
    }
  }




}