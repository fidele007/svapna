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
}
