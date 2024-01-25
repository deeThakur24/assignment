class Assets {
  static final Assets _singleton = Assets._internal();
  Assets._internal();
  static Assets get instance => _singleton;

  String get noEmployee => 'assets/images/no_employee.svg';
  String get person => 'assets/images/person.svg';
  String get calendar => 'assets/images/calendar.svg';
  String get work => 'assets/images/work.svg';
  String get arrowRight => 'assets/images/arrow_righ.svg';
}
