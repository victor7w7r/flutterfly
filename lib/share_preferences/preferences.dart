import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class Preferences {

  static late SharedPreferences _prefs;

  static bool _darkModeMaterial = false;
  static bool _darkModeCupertino = false;
  static bool _darkModeFluent = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkModeMaterial {
    return _prefs.getBool('material') ?? _darkModeMaterial;
  }

  static set darkModeMaterial(bool value) {
    _darkModeMaterial = value;
    _prefs.setBool('material', value );
  }

  static bool get darkModeCupertino {
    return _prefs.getBool('cupertino') ?? _darkModeCupertino;
  }

  static set darkModeCupertino(bool value) {
    _darkModeCupertino = value;
    _prefs.setBool('cupertino', value );
  }

    static bool get darkModeFluent {
    return _prefs.getBool('fluent') ?? _darkModeFluent;
  }

  static set darkModeFluent(bool value) {
    _darkModeFluent = value;
    _prefs.setBool('fluent', value );
  }
}