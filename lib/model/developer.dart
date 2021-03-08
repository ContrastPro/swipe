class DeveloperBuilder {
  DeveloperBuilder();

  DeveloperBuilder.fromMap(Map<String, dynamic> map);

  @override
  String toString() {
    return '\n********************************\n'
        '--- DeveloperBuilder ---'
        '\n>> '
        '\n********************************\n';
  }
}

class Developer {
  Developer(DeveloperBuilder developerBuilder);

  Map<String, dynamic> toMap() {
    return {
      "": "",
    };
  }
}
