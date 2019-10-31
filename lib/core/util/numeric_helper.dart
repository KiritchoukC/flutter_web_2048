bool isNumeric(String s) {
  if (s == null) {
    return false;
  }

  return num.tryParse(s) != null;
}
