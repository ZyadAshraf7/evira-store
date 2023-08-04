import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  static LatLng currentPosition = LatLng(37.7749, -122.4194);
  CameraPosition initialCameraPosition = CameraPosition(target: currentPosition,zoom: 15); // Default position

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
          Padding(
            padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
            child: Row(
              children: [
                Expanded(child: CustomButton(onTap: ()async{
                  print(currentPosition);

                  List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
                  print(placemarks.first.street);
                }, title: "Select Location",))
              ],
            ),
          )
        ],
      ),
    );
  }
}
