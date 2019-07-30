class StringUtil {
  static bool isEmpty(String str) {
    return str == null && str.isEmpty;
  }

  static bool isNotEmpty(String str) {
    return str != null && str.isNotEmpty;
  }

  static bool equals(String str1, String str2) {
    return str1 == str2;
  }

  static String notNull(String text, {String def: ''}) {
    return text ?? def;
  }
}
