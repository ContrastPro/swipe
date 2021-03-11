class BuildingBuilder {
  String id;
  String ownerUID;
  String address;
  String description;

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
  final String id;
  final String ownerUID;
  final String address;
  final String description;

  Building(BuildingBuilder buildingBuilder)
      : id = buildingBuilder.id,
        ownerUID = buildingBuilder.ownerUID,
        address = buildingBuilder.address,
        description = buildingBuilder.description;

  Map<String, dynamic> toMap() {
    return {
      "address": address,
    };
  }
}
