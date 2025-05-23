const String mahalName =
    "NOORUL HUDHA MADRASA\n(A) BRANCH, PALLIPPARAMB\nTIRURANGADI";

class APIs {
  static const String baseUrl = "https://nhmabranchtgi.com/api/";
  static const String login = "${baseUrl}login_action_admin.php";
  static const String getSubsDetlsHouseByNumber =
      "${baseUrl}get_subscription.php";
  static const String getSubsDetailsByDateWise =
      "${baseUrl}get_subscription_datewise.php";
  static const String getSubsDetailsToday =
      "${baseUrl}get_subscription_today_collection.php";

  static const String addSubscription = "${baseUrl}add_subscription.php";
  static const String getHouseBasicDetails = "${baseUrl}get_profile_family.php";
}
