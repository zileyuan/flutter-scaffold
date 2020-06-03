class FormatUtil {
  static String stripTrailingZeros(String value) {
    var pos = value.indexOf('.');
    if (pos > -1) {
      var len = value.length;
      for (var i = len - 1; i >= 0; i--) {
        var c = value[i];
        if (c == '0') {
          continue;
        } else if (c == '.') {
          return value.substring(0, pos);
        } else {
          return value.substring(0, len - i + 1);
        }
      }
    }
    return value;
  }
}
