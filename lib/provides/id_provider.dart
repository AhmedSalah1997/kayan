// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> documentId;
  late String doctId;
  static String _anyoneId = '';

  String get getData {
    return _anyoneId;
  }

  setCustomerId(User user) async {
    final SharedPreferences prf = await _prefs;
    prf
        .setString('anyoneid', user.uid)
        .whenComplete(() => _anyoneId = user.uid);
    print('anyoneid  was saved into shPrefrance and create one ');
    notifyListeners();
  }

  clearCustomerId() async {
    final SharedPreferences prf = await _prefs;
    prf.setString('anyoneid', '').whenComplete(() => _anyoneId = '');
    print('anyoneid  was clearrrrrr from shPrefrance');
    notifyListeners();
  }

  Future<String> getDocumentId() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString('anyoneid') ?? '';
    });
  }
   getDocId ()async{
    await getDocumentId().then((value) => _anyoneId=value);
    print('anyoneid was update into provider');
    notifyListeners();
  }
}
