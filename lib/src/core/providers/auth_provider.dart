import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends ChangeNotifier {
  bool isloggedIn = false;
  void login(){
    isloggedIn = true;
    notifyListeners();
  }
   void logout(){
    isloggedIn = false;
    notifyListeners();
  }
  
}
final  authProvider= ChangeNotifierProvider<AuthNotifier>((ref){
  return AuthNotifier();
});