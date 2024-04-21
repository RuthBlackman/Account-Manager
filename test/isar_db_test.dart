import 'dart:io';
import 'package:account_manger/helpers/helpers.dart';
import 'package:account_manger/models/account.dart';
import 'package:account_manger/models/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {

  late Isar isarTest;
  late Directory dirTest;

  setUp(() async {
    dirTest = Directory.systemTemp.createTempSync();
    await Isar.initializeIsarCore(download: true);

    if(Isar.instanceNames.isEmpty){
      isarTest = await Isar.open(
          [AccountSchema, AppSettingsSchema],
          directory: dirTest.path);
    }

  });



  /*
    To test:
        Create account for device: name + category
        Create basic account: name, cat, username, password

        Read accounts

        Edit account: name, cat, username, password

        Edit account: add access type to incomingAccounts
        Edit account: add account_id to incomingAccounts

        Delete account
   */



  test("Open instance of Isar database", () async {
    final isOpen = isarTest.isOpen;
    expect(isOpen, true);
  });

  final device = Account()
    ..name = "Phone"
    ..category = "Physical Device"
    ..username= ""
    ..password = "";


  final basic_account = Account()
    ..name = "Google"
    ..category = "Email"
    ..username = "test_username@gmail.com"
    ..password = "very_good_password";

  final basic_account_2 = Account() // deserves 2 points and 1 star
    ..name = "Facebook"
    ..category = "Social Media"
    ..username = "test_username@facebook.com"
    ..password = "very_long_password";

  final account_with_access_type = Account() // deserves 3 points and 2 stars (3 stars if incoming accounts has id)
    ..name = "Discord"
    ..category = "Social Media"
    ..username = "user@discord.com"
    ..password = "very_secure_password"
    ..incomingAccounts = ["2FA:"];

  final weak_account = Account()
    ..name = "Spotify"
    ..category = "Entertainment"
    ..username = "user@spotify.com"
    ..password = "bad";

  group("Testing Account Creation", () {
    /*
    Create an account with just a name and a category - used for physical devices
     */
    test("Create an account for a device", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(device);
      });

      final deviceAcc = await isarTest.accounts.get(device.id);
      expect(deviceAcc?.id, device.id);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

    /*
    Create an account with just basic details - name, category, username, password
     */
    test("Create a basic account", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
      });

      final acc = await isarTest.accounts.get(basic_account.id);
      expect(acc?.id, basic_account.id);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });
  });

  group("Testing Account Read", (){
    /*
    Add account to database and then read it
     */
    test("Read Account object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
      });

      final retrievedAccount = await isarTest.accounts.get(1);
      expect(retrievedAccount?.name, "Google");
      expect(retrievedAccount?.id, 1);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

    /*
    Add two accounts to database and then read them
     */
    test("Read all Accounts", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
        await isarTest.accounts.put(account_with_access_type);
      });

      final allAccounts = await isarTest.accounts.where().findAll();

      expect(allAccounts.length, 2);
      expect(allAccounts.first.id, basic_account.id);
      expect(allAccounts.last.id, account_with_access_type.id);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });
  });

  group("Testing Account Modification", (){
    /*
    Edit the password of the account
     */
    test("Update Account object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
      });

      Account? updateAccount = await isarTest.accounts.get(1);
      print(updateAccount);

      updateAccount?.name = "Changed Name";

      Account? acc = updateAccount;

      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(acc!);
      });

      final newAccount = await isarTest.accounts.get(acc!.id);

      expect(newAccount?.id, basic_account.id);
      expect(newAccount?.name, "Changed Name");

    });


    /*

     */
    test("Add access type to account", () async {
      Account? updatedAccount;

      basic_account.incomingAccounts = ["2FA:"];

      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
      });


      await isarTest.writeTxn(() async {
        updatedAccount = await isarTest.accounts.get(1);
      });

      expect(updatedAccount?.incomingAccounts, ["2FA:"]);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });



    test("Add account id to account", () async {
      // add account with access type and device to accounts
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(device);
        await isarTest.accounts.put(account_with_access_type);
      });

      final deviceAcc = await isarTest.accounts.get(device.id);

      // remove ["2FA:"]
      Account? oldAccount;
      await isarTest.writeTxn(() async {
        oldAccount = await isarTest.accounts.get(2);
      });

      List<String>? oldIncomingAccounts = oldAccount?.incomingAccounts.toList();
      oldIncomingAccounts?.removeWhere((element) => element.contains("2FA") == true);

      // add ["2FA:device_id"]
      oldIncomingAccounts?.add("2FA:${deviceAcc?.id}");

      // create account with new incomingAccounts
      Account newAccount = Account();
      newAccount.incomingAccounts = oldIncomingAccounts!;
      newAccount.name = oldAccount!.name;
      newAccount.category = oldAccount!.category;
      newAccount.username = oldAccount!.username;
      newAccount.password = oldAccount!.password;

      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(newAccount);
      });

      // verify incomingAccounts now has string with access type AND id
      Account? updatedAccount;

      await isarTest.writeTxn(() async {
        updatedAccount = await isarTest.accounts.get(3);
      });

      expect(updatedAccount?.incomingAccounts, ["2FA:${deviceAcc?.id}"]);

      // clear
      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });
  });

  group("Testing Account Deletion", (){
    test("Delete Account object", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account);
      });

      await isarTest.writeTxn(() async {
        await isarTest.accounts.delete(basic_account.id);
      });

      final deletedAccount = await isarTest.accounts.get(1);
      expect(deletedAccount, isNull);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      } );
    });
  });



  group("Testing Gamification (Stars + Points)", () {
    test("Filling in only basic account details is worth 1 star", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account_2);
      });

      final acc = await isarTest.accounts.get(1);

      int num = numberOfStars(acc!);

      expect(num, 1);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

    test("Edit basic account to earn 3 stars", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(basic_account_2);
      });

      Account? oldAccount;
      oldAccount = await isarTest.accounts.get(1);

      List<String>? oldIncomingAccounts = oldAccount?.incomingAccounts.toList();
      oldIncomingAccounts?.add("2FA:${device.id}");

      Account newAccount = Account();
      newAccount.incomingAccounts = oldIncomingAccounts!;
      newAccount.name = oldAccount!.name;
      newAccount.category = oldAccount!.category;
      newAccount.username = oldAccount!.username;
      newAccount.password = oldAccount!.password;

      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(newAccount);
      });

      final betterAccount = await isarTest.accounts.get(2);
      int newNumberStars = numberOfStars(betterAccount!);

      expect(newNumberStars, 3);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

    test("Filling in only basic account details with short password is worth 1 point", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(weak_account);
      });

      final acc = await isarTest.accounts.get(1);

      final numOfPoints = numberOfPoints(acc!);

      expect(numOfPoints, 1);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

    test("Filling in basic details with long password + enable 2FA + password manager is worth 4 points", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(weak_account);
      });

      final weakAcc = await isarTest.accounts.get(1);

      List<String> accounts = weakAcc!.incomingAccounts.toList();
      accounts.add("2FA:");
      accounts.add("Password Manager:");
      weakAcc?.incomingAccounts = accounts;
      weakAcc?.password = "much_better_password!!";

      Account newAcc = Account();
      newAcc.name = weakAcc!.name;
      newAcc.category = weakAcc!.category;
      newAcc.username = weakAcc!.username;
      newAcc.password = weakAcc!.password;
      newAcc.incomingAccounts = accounts;

      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(newAcc);
      });

      final betterAccount = await isarTest.accounts.get(2);

      final numOfPoints = numberOfPoints(betterAccount!);

      expect(numOfPoints, 4);

      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      });
    });

  });


  group("Testing account recommendations", () {
    test("Calculate list of recommendations to improve account security", () async {
      await isarTest.writeTxn(() async {
        await isarTest.accounts.put(weak_account);
      });

      final acc = await isarTest.accounts.get(weak_account.id);

      final recommendations = getRecommendations(acc!);

      expect(recommendations, ["Enable Two-Factor Authentication", "Password should have at least 10 characters", "Store password with Password Manager"]);


      await isarTest.writeTxn(() async {
        await isarTest.accounts.clear();
      } );
    });
  });



  tearDownAll(() async {
    await isarTest.close(deleteFromDisk: true);
  });
}

