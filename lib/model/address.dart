import 'package:cloud_firestore/cloud_firestore.dart';

class AddressBuilder {
  String address;
  GeoPoint geo;

  @override
  String toString() {
    return '\n********************************\n'
        '--- AddressBuilder ---'
        '\n>> address: $address, '
        '\n>> geo: ${geo.latitude} ${geo.longitude}'
        '\n********************************\n';
  }
}