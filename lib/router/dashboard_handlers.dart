import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return LoginView();
      } else {
        return DashboardView();
      }
      
    } 
  );
}