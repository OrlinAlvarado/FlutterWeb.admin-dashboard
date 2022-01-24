
import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Fluroruter {
  static final FluroRouter router = FluroRouter();
  
  static String rootRoute     = '/auth/login';
  //Auth Router
  static String loginRoute    = '/auth/login';
  static String registerRoute = '/auth/register';
  
  //Dashboard
  static String dashboardRoute = '/dashboard';
  
  static void configureRoutes(){
    //Auth Routes
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);
    
    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
  
  
  
  
  
}