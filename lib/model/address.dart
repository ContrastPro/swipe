import 'package:cloud_firestore/cloud_firestore.dart';

class AddressBuilder {
  String address;
  GeoPoint geo;

  @override
  String toString() {
    return 'AddressBuilder {address: $address, '
        'geo: ${geo.latitude} ${geo.longitude}}';
  }
}