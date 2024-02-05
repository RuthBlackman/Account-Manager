import 'package:account_manger/models/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'account.dart';

class AccountDatabase extends ChangeNotifier{
  static late Isar isar;

  /*
  Setup database
   */

  // Initialise Database
  static Future<void> initialise() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [AccountSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // save first date of app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if(existingSettings == null){
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // get first date of app startup
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD operations
   */

  final List<Account> currentAccounts = [];

  // Create
  Future<void> addAccount(String accountName, String category, String username, String password )async {
    // create new account
    final newAccount = Account()..name = accountName;
    newAccount.category = category;
    newAccount.username = username;
    newAccount.password = password;

    // save to db
    await isar.writeTxn(() => isar.accounts.put(newAccount));

    // re-read from db
    readAccounts();
  }

  // Create
  Account createEmptyAccount( )  {
    final newAccount = Account()..name = "Account";
    newAccount.category = "";
    newAccount.username = "";
    newAccount.password = "";

    // save to db
    isar.writeTxn(() => isar.accounts.put(newAccount));

    // re-read from db
    readAccounts();

    return newAccount;
  }


  // Read saved accounts from db
  Future<void> readAccounts() async{
    // fetch all accounts from db
    List<Account> fetchedAccounts = await isar.accounts.where().findAll();

    // give to current accounts
    currentAccounts.clear();
    currentAccounts.addAll(fetchedAccounts);

    // notify UI
    notifyListeners();
  }

  // Update
  // update all parameters
  // Future<void> editAccount(int id, String name, String category, String username, String password) async {
  //   // find the specific account
  //   final account = await isar.accounts.get(id);
  //
  //   // update fields
  //   // name and category are mandatory for every account (even a device can have this)
  //   if(name != null && category != null){
  //     await isar.writeTxn(() async {
  //       // update fields
  //       account!.name = name;
  //       account!.category = category;
  //       account.username = username;
  //       account.password = password;
  //
  //       // save updated account back to db
  //       await isar.accounts.put(account);
  //     });
  //   }
  //
  //   // re-read from db
  //   readAccounts();
  //
  // }

  Future<void> updateAccount(Account a) async {
    await isar.writeTxn(() async {
      await isar.accounts.put(a);
    });


    // re-read from db
    readAccounts();

  }




  // Create
  Future<void> addAccountTest(String accountName, String category, String username, String password, String typeOfAccess, int idOfIncomingAccount )async {
    // create new account
    final newAccount = Account()..name = accountName;
    newAccount.category = category;
    newAccount.username = username;
    newAccount.password = password;

    // save to db
    await isar.writeTxn(() => isar.accounts.put(newAccount));

    await isar.writeTxn(() async {
      // update fields
      newAccount?.incomingAccounts = [...newAccount.incomingAccounts, "Password Manager:1", "2FA:1", "SSO:1", "Recovery:1"];

      // save updated account back to db
      await isar.accounts.put(newAccount!);
    });

    // re-read from db
    readAccounts();
  }

  // Future<void> addAccessType(int id, String typeOfAccess, [int? idOfIncomingAccount]) async {
  //   // find the specific account
  //   final account = await isar.accounts.get(id);
  //
  //   await isar.writeTxn(() async {
  //     // update fields
  //     account?.incomingAccounts = [...account.incomingAccounts, "${typeOfAccess}:"];
  //
  //     // save updated account back to db
  //     await isar.accounts.put(account!);
  //   });
  //
  //   readAccounts();
  // }
  //
  // Future<void> removeAccessType(int id, String typeOfAccess, [int? idOfIncomingAccount]) async {
  //   final account = await isar.accounts.get(id);
  //
  //   List<String>? incomingAccounts = account?.incomingAccounts.toList();
  //
  //   incomingAccounts?.removeWhere((element) => element.contains(typeOfAccess) == true);
  //
  //   await isar.writeTxn(() async {
  //     account?.incomingAccounts = incomingAccounts!;
  //
  //     await isar.accounts.put(account!);
  //   });
  //
  //   readAccounts();
  // }

  // Delete account
  Future<void> deleteAccount(int id) async {
    await isar.writeTxn(() async {
      await isar.accounts.delete(id);
    });

    readAccounts();
  }
}