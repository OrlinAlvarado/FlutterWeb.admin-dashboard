import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  
  String _currentPage = '';
  
  String get currentPage {
    return _currentPage;
  }  
  
  void setCurrentPage( String routeName ){
    _currentPage = routeName;
    Future.delayed( const Duration(milliseconds: 100), (){
      notifyListeners();
    });
  }
  
  static late AnimationController menuController;
  static bool isOpen = false;
  
  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
    .animate(CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
    
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1)
    .animate(CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  
  static void openMenu(){
    isOpen = true;
    menuController.forward();
  }
  
  static void closeMenu(){
    isOpen = false;
    menuController.reverse();
  }
  
  static void toggleMenu(){
    ( isOpen )
      ? menuController.reverse()
      : menuController.forward();
      
    isOpen = !isOpen;
  }
    
  
}