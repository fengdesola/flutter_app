class CoreConstant {
  static bool debug = false;
  static String baseUrl = '';

  static init(bool debug, String baseUrl) {
    CoreConstant.debug = debug;
    CoreConstant.baseUrl = baseUrl;
  }
}
