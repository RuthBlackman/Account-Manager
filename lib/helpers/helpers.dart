import 'package:account_manger/constants/waysToGetPoints.dart';

import '../models/account.dart';

int numberOfStars(Account account){
  /*
    1 star = filled in name, category, username, password
    1 star = at least one checkbox ticked
    1 star = some accounts/devices added to page 2
   */

  int total = 0;
  if(account?.name!= "Account" && account?.category != "" &&
      account?.username != "" && account?.password != ""){
    ++total;
  }

  if(account!.incomingAccounts.toList().isNotEmpty){
    ++total;
  }

  for(String string in account!.incomingAccounts.toList()){
    if(string.substring(string.length-1) != ":"){
      ++total;
      break;
    }
  }

  return total;
}

int numberOfPoints(Account account){
  /*
    First implementation of score:
      length of password = 0-2 points
      2FA? = 1 point
      Password Manager? = 1 point
   */

  int total = 0;

  if(account.password.isNotEmpty && account.password.length <= 10){
   ++total;
  }else if(account.password.length >10){
    total +=2;
  }

  if(account.incomingAccounts.where((element) => element.contains("2FA")).isNotEmpty){
    ++total;
  }

  if(account.incomingAccounts.where((element) => element.contains("Password Manager")).isNotEmpty){
    ++total;
  }

  return total;
}

List<String> getRecommendations(Account account){
  List<String> recommendations = [];

  // check if 2fa enabled
  if(account.incomingAccounts.where((element) => element.contains("2FA")).isEmpty){
    // add account to list
    recommendations.add(WaysToGetPointsHelper.getValue(WaysToGetPoints.TwoFactorAuthentication));
  }

  // check password length
  if(account.password.length < 10){
    recommendations.add(WaysToGetPointsHelper.getValue(WaysToGetPoints.LongPassword));
  }

  // check if using password manager
  if(account.incomingAccounts.where((element) => element.contains("Password Manager")).isEmpty){
    recommendations.add(WaysToGetPointsHelper.getValue(WaysToGetPoints.PasswordManager));
  }

  return recommendations;

}