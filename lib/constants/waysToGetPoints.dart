
enum WaysToGetPoints {
  TwoFactorAuthentication,
  PasswordManager,
  LongPassword;

}

class WaysToGetPointsHelper {
  static String getValue(WaysToGetPoints way){
    switch(way){
      case WaysToGetPoints.TwoFactorAuthentication:
        return "Enable Two-Factor Authentication";
      case WaysToGetPoints.PasswordManager:
        return "Store password with Password Manager";
      case WaysToGetPoints.LongPassword:
          return "Password should have at least 10 characters";
      default:
          return "";
    }
  }
}