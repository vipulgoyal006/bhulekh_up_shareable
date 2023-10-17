mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');
  static bool get isLocal => environment == "local";
  static bool get isDev => environment == "dev";
  static bool get isProd => environment == "prod";

  static const hostedUrl = 'https://upbhulekh.gov.in/';
  static const String baseApiUrl = 'https://upbhulekh.gov.in/';

  // static const googleClientId =
  //     '';
  // static const iosClientId =
  //     '';

  static const fontFamily = "Poppins";
}
