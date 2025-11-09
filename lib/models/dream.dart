class Dream {
  int id;
  String name;
  String definition;
  String? plainTextDefinition;

  Dream({required this.id, required this.name, required this.definition}) {
    plainTextDefinition = convertHtmlToPlainText(definition);
  }

  String convertHtmlToPlainText(String definition) {
    return definition
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'definition': definition,
    };
  }

  static Dream fromJson(Map<String, dynamic> dreamJson) {
    return Dream(
      id: dreamJson['id'],
      name: dreamJson['name'],
      definition: dreamJson['definition'],
    );
  }
}
