import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/ui/views/no_page_found_view.dart';
import 'package:provider/provider.dart';

import '../providers/sidemenu_provider.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(
    handlerFunc:  (context, params ) {
      Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPage('/404');
        
      return const NoPageFoundView();
    } 
  );
}