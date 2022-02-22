import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/register_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';

class AdminHandlers {
  static Handler login = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const LoginView();
      } else {
        return const DashboardView();
      }
    } 
  );
  static Handler register = Handler(
    handlerFunc:  (context, params ) {
      
      final authprovider = Provider.of<AuthProvider>(context!);
      
      if(authprovider.authStatus == AuthStatus.notAuthenticated){
        return const RegisterView();
      } else {
        return const DashboardView();
      }
    } 
  );
}