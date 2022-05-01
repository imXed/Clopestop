import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static SharedPreferences? _preferences;
  static const _keyDate = 'date';
  static const _keyDate2 = 'date2';
  static const _keySigNotSmoked = 'sigNotSmoked';
  static const _keyUsername = 'username';
  static const _keySigPerDay = 'sigPerDay';
  static const _keySigSmoked = 'sigSmoked';
  static const _keySigInPacket = 'sigInPacket';
  static const _keyPrice = 'price';
  static const _keyMoney = 'money';
  static const _keySignUp = 'SignUp';
  static const _keyIsFuming = 'isFuming';
  static const _keyNotSmoking = 'notSmoking';
  static const _keyminwithoutS = 'minwithoutS';
  static const _keyhourswithoutS = 'hourswithoutS';
  static const _keyCigAvoided = 'cigAvoided';
  static const _keyMoneyspent = 'moneySpent';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  // username
  static Future setUsername(String username) async =>
      await _preferences?.setString(_keyUsername, username);
  static String? getUsername() => _preferences?.getString(_keyUsername);
  // cigarettes used to smoke per day
  static Future setSigPerDay(int sigPerDay) async =>
      await _preferences?.setInt(_keySigPerDay, sigPerDay);
  static int? getSigPerDay() => _preferences?.getInt(_keySigPerDay);
  // cigarettes smoked this day
  static Future setSigSmoked(int sigSmoked) async =>
      await _preferences?.setInt(_keySigSmoked, sigSmoked);
  static int? getSigSmoked() => _preferences?.getInt(_keySigSmoked);
  // date of joining the app
  static Future setDate(String date) async =>
      await _preferences?.setString(_keyDate, date);
  static String? getDate() => _preferences?.getString(_keyDate);
  // price of a packet

  static Future setPrice(int price) async =>
      await _preferences?.setInt(_keyPrice, price);
  static int? getPrice() => _preferences?.getInt(_keyPrice);

  // cigarettes in a packet
  static Future setSigInPacket(int sigInPacket) async =>
      await _preferences?.setInt(_keySigInPacket, sigInPacket);
  static int? getSigInPacket() => _preferences?.getInt(_keySigInPacket);
  // Money saved
  static Future setMoneySaved(int money) async =>
      await _preferences?.setInt(_keyMoney, money);
  static int? getMoneySaved() => _preferences?.getInt(_keyMoney);
  // date2
  static Future setDate2(int date2) async =>
      await _preferences?.setInt(_keyDate2, date2);
  static int? getDate2() => _preferences?.getInt(_keyDate2);
  // cigarettes not smoked
  static Future setSigNotSmoked(int sigNotSmoked) async =>
      await _preferences?.setInt(_keySigNotSmoked, sigNotSmoked);
  static int? getSigNotSmoked() => _preferences?.getInt(_keySigNotSmoked);
  // sign up
  static Future setSignup(int SignUp) async =>
      await _preferences?.setInt(_keySignUp, SignUp);
  static int? getSignup() => _preferences?.getInt(_keySignUp);
  //to know if the user is still smoking or not
  static Future setIsSmoking(int isFuming) async =>
      await _preferences?.setInt(_keyIsFuming, isFuming);
  static int? getIsSmoking() => _preferences?.getInt(_keyIsFuming);

  // days without smoking
  static Future setDaysWithoutSmoking(int notSmoking) async =>
      await _preferences?.setInt(_keyNotSmoking, notSmoking);
  static int? getDaysWithoutSmoking() => _preferences?.getInt(_keyNotSmoking);
  // hours without smoking
  static Future setHoursWithoutSmoking(int hourswithoutS) async =>
      await _preferences?.setInt(_keyhourswithoutS, hourswithoutS);
  static int? getHoursWithoutSmoking() =>
      _preferences?.getInt(_keyhourswithoutS);
  // minuts without smoking
  static Future setminWithoutSmoking(int minwithoutS) async =>
      await _preferences?.setInt(_keyminwithoutS, minwithoutS);
  static int? getminWithoutSmoking() => _preferences?.getInt(_keyminwithoutS);
  // cig to avoid today
  static Future setCigAvoided(int cigAvoided) async =>
      await _preferences?.setInt(_keyCigAvoided, cigAvoided);
  static int? getCigAvoided() => _preferences?.getInt(_keyCigAvoided);
  // to save the money spent to buy objectives
  static Future setMoneySpent(int moneySpent) async =>
      await _preferences?.setInt(_keyMoneyspent, moneySpent);
  static int? getMoneyspent() => _preferences?.getInt(_keyMoneyspent);
}
