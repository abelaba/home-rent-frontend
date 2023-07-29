// Imports the Flutter Driver API.
// @dart = 2.8

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver.close();
  });
  group('View without login', () {
    final viewwithoutaccount = find.byValueKey("viewwithoutaccount");
    final singlerental = find.text('France');

    test("View posts without logging in", () async {
      await driver.tap(viewwithoutaccount);
      await driver.waitFor(find.text("All properties"));
      print(singlerental);

      await driver.tap(singlerental);
      await driver.waitFor(find.text("Start chat"));

      await driver.tap(find.byType("Icon"));
      await driver.waitFor(find.text("All properties"));

      await driver.tap(find.byType("IconButton"));
    });
  });
  group('Login and signup', () {
    // signUp
    final snamefield = find.byValueKey('signupnamefield');
    final semailfield = find.byValueKey('signupemailfield');
    final phonenumberfield = find.byValueKey('phonenumberfield');
    final spasswordfield = find.byValueKey('signuppasswordfield');
    final signupbutton = find.byValueKey('signupbutton');

    //login
    final lemailfield = find.byValueKey('loginemailfield');
    final lpasswordfield = find.byValueKey('loginpasswordfield');
    final loginbutton = find.byValueKey('loginbutton');
    final donthaveanaccount = find.byValueKey("donthaveanaccount");

    test("Sign up and login", () async {
      await driver.tap(lemailfield);
      await driver.enterText("squa@gmail.com");

      await driver.tap(lpasswordfield);
      await driver.enterText("password");

      await driver.tap(loginbutton);

      await driver.waitFor(find.text("Login"));

      await driver.tap(donthaveanaccount);

      await driver.tap(snamefield);
      await driver.enterText("IamGhost");

      await driver.tap(semailfield);
      await driver.enterText("ghost@gmail.com");

      await driver.tap(phonenumberfield);
      await driver.enterText("0912322321");

      await driver.tap(spasswordfield);
      await driver.enterText("password");

      await driver.tap(signupbutton);

      await driver.waitFor(find.text("Login"));

      await driver.tap(lemailfield);
      await driver.enterText("ghost@gmail.com");

      await driver.tap(lpasswordfield);
      await driver.enterText("password");

      await driver.tap(loginbutton);
      await driver.waitFor(find.text("Post"));
    });
  });

  group('Rental', () {
    test("Add rental", () async {
      await driver.tap(find.byType("FloatingActionButton"));
      await driver.waitFor(find.text("Add New property"));
      await driver.tap(find.byValueKey("address"));
      await driver.enterText("My home");
      await driver.tap(find.byValueKey("addimage"));
      await driver.waitFor(find.text("Add New property"));

      await driver.tap(find.byType("IconButton"));

      await driver.waitFor(find.byValueKey("Post"));
    });

    test("View posts", () async {
      await driver.tap(find.byValueKey("Home"));

      await driver.waitFor(find.text("All properties"));

      await driver.tap(find.text('France'));
    });
  });

  group('Chat', () {
    test("Start chat", () async {
      await driver.tap(find.text("Start chat"));
      await driver.waitFor(find.text("Post"));
      await driver.tap(find.byValueKey("Chats"));
      await driver.tap(find.text("IamGhost"));
      await driver.tap(find.byType("TextFormField"));
      await driver.enterText("Hello");
      await driver.tap(find.byValueKey("sendbutton"));
      await driver.waitFor(find.text("Hello"));
      await driver.tap(find.byValueKey("backbutton"));
      await driver.waitFor(find.text("Chats"));
    });
  });

  group('User Settings', () {
    test("Settings", () async {
      await driver.tap(find.byValueKey("Account"));
      await driver.waitFor(find.text("User Account"));

      await driver.tap(find.text("Update Account"));
      await driver.waitFor(find.text("Update"));

      await driver.tap(find.byValueKey("namefield"));
      await driver.enterText("IamGhosts");

      await driver.tap(find.byValueKey("emailfield"));
      await driver.enterText("ghosts@gmail.com");

      await driver.tap(find.byValueKey("passwordfield"));
      await driver.enterText("password");

      await driver.tap(find.byValueKey("phonenumberfield"));
      await driver.enterText("0000000000");

      await driver.tap(find.text('Update'));

      await driver.tap(find.byValueKey("Account"));
      await driver.tap(find.text("Delete Account"));
      await driver.tap(find.text('Yes'));
    });
  });
}
