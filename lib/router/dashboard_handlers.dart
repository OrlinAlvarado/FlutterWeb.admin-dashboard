import 'package:admin_dashboard/router/router.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';

import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(Fluroruter.dashboardRoute);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const LoginView();
      } else {
        return const DashboardView();
      }
      
    } 
  );
  static Handler icons = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(Fluroruter.iconsRoute);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const LoginView();
      } else {
        return const IconsView();
      }
      
    } 
  );
  static Handler blank = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(Fluroruter.blankRoute);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const LoginView();
      } else {
        return const BlankView();
      }
      
    } 
  );
  static Handler categories = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPage(Fluroruter.categoriesRoute);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const LoginView();
      } else {
        return const CategoriesView();
      }
      
    } 
  );
}