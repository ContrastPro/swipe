class BuildingBuilder {
  String address;

  BuildingBuilder();

  BuildingBuilder.fromMap(Map<String, dynamic> map) : address = map["address"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- BuildingBuilder ---'
        '\n>> address: $address'
        '\n********************************\n';
  }
}

class Building {
  final String address;

  Building(BuildingBuilder buildingBuilder) : address = buildingBuilder.address;

  Map<String, dynamic> toMap() {
    return {
      "address": address,
    };
  }
}
