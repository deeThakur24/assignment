
class AppConstants{
  static final AppConstants _singleton = AppConstants._internal();

  AppConstants._internal();

  static AppConstants getInstance() {
    return _singleton;
  }
  static const headerContentType = 'Content-Type';
// Used to determine weather the change user name bottom sheet shown or not
  bool isBottomSheetShown = true;
  late double deviceHeight;
  late double deviceWidth;

// Error Messages
  static const String errorPageNotFound = 'Page Not Found';
  static const String errorInternetNotAvailable = 'Please check your network!';
}

