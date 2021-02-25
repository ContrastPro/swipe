import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/model/apartment.dart';

class HomeMapWidget extends StatefulWidget {
  final List<ApartmentBuilder> apartmentList;

  const HomeMapWidget({
    Key key,
    @required this.apartmentList,
  }) : super(key: key);

  @override
  _HomeMapWidgetState createState() => _HomeMapWidgetState();
}

class _HomeMapWidgetState extends State<HomeMapWidget> {
  List<Marker> _markerList = List<Marker>();

  @override
  void initState() {
    _addMarkers();
    super.initState();
  }

  void _addMarkers() {
    widget.apartmentList.forEach((apartment) {
      _markerList.add(
        Marker(
          markerId: MarkerId(apartment.id),
          position: LatLng(
            apartment.geo.latitude,
            apartment.geo.longitude,
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(
      await DefaultAssetBundle.of(context).loadString(
        "assets/map/map_style.json",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      //zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(46.47747, 30.73262),
        zoom: 15.0,
      ),
      markers: Set.from(_markerList),
    );
  }
}
