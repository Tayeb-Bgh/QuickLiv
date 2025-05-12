import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:mobileapp/features/maps_example/polyline_current_to_destination.dart';

class Maps extends StatefulWidget {
  const Maps({super.key, required this.destinationPos, required this.selected});
  final LatLng destinationPos;
  final bool selected;
  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        backgroundColor: kPrimaryRed,
      ),
      body: Expanded(
        child:   GoogleMapsPageToDest(destinationPos: widget.destinationPos) ,
      ),
    );  }
}
