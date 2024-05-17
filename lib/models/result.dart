enum Result {
  nothing,
  cow,
  bull;

  factory Result.fromString(String resultAsString) {
    for (Result element in Result.values) {
      if (element.name == resultAsString.toLowerCase()) {
        return element;
      }
    }
    throw Exception();
  }
}
