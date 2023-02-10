abstract class Helpers {
  // THIS FUNCTION IS USED TO CONVERT ANY TYPE OF VALUE TO DOUBLE //
  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  static String toUpperCase(String _name) {
    String _n = '';
    if (_name != '' && _name.length > 0) {
      _n = _name[0].toUpperCase();
      if (_name.length > 1) {
        _n += _name.substring(1);
      }
    }
    return _n;
  }
}
