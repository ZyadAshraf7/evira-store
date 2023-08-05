import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_router/route_names.dart';
import '../../cubits/get_user_info/get_user_info_cubit.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  static LatLng currentPosition = const LatLng(30.033333, 31.233334);
  CameraPosition initialCameraPosition = CameraPosition(target: currentPosition,zoom: 15); // Default position
  TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {


    String kPLACES_API_KEY = "AIzaSyCYy4lI7c88j-y2yP2Ql7RJHjjlvOalits";

    try{
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
      // toastMessage('success');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(initialCameraPosition:initialCameraPosition ,
            onTap: (LatLng pos){
              setState(() {
                currentPosition = pos;
              });
            },
            markers: {
              Marker(
                markerId: MarkerId('selected_location'),
                position: currentPosition,
                draggable: true,
                onDragEnd: (LatLng newPosition) {
                  print(newPosition);
                  currentPosition = newPosition;
                },
              ),
            },
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0,left: 16,top: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,

                  ),
                  controller: _controller,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
                child: Row(
                  children: [
                    Expanded(child: CustomButton(onTap: ()async{
                      print(currentPosition);

                      List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
                      print(placemarks.first.street);
                      print(placemarks.first.locality);
                      String country = placemarks.first.country??"";
                      String street = placemarks.first.street??"";
                      String locality = placemarks.first.locality??"";
                      print(placemarks.first.thoroughfare);
                      String address = "$country - $locality - $street";
                      BlocProvider.of<GetUserInfoCubit>(context).updateUserAddress(address).then((value){
                            Navigator.of(context).pop();
                      });
                    }, title: "Select Location",))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
