String generateCountryFlag() {
  String countryCode = 'EG';
  return countryCode.replaceAllMapped(
    RegExp(r'[A-Z]'),
    (match) => String.fromCharCode(
      match.group(0)!.codeUnitAt(0) + 127397,
    ),
  );
}
