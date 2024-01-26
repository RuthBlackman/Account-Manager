import 'package:isar/isar.dart';

part 'account.g.dart';

@Collection()
class Account {

  Id id = Isar.autoIncrement;

  late String name;
  late String category;
  late String username;
  late String password;

  final incomingAccounts = IsarLinks<Account>();

  // late bool password_generated;
  // late bool user_password_strong;


}