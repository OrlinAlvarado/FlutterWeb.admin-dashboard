import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({ Key? key }) : super(key: key);
  
  void navigateTo( String routeName ){
    NavigationService.navigateTo( routeName );
    SideMenuProvider.closeMenu();
  }
  
  @override
  Widget build(BuildContext context) {
    
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          
          const SizedBox( height: 50,),
          
          const TextSeparator( text: 'main' ),
          
          MenuItem( 
            text: 'Dashboard', 
            icon: Icons.compass_calibration_outlined, 
            onPressed: () => navigateTo( Fluroruter.dashboardRoute ),
            isActive: sideMenuProvider.currentPage == Fluroruter.dashboardRoute,
          ),
          MenuItem( text: 'Orders', icon: Icons.shopping_cart_outlined, onPressed: () => {} ),
          MenuItem( text: 'Analytics', icon: Icons.show_chart_outlined, onPressed: () => {} ),
          MenuItem( 
            text: 'Categories', 
            icon: Icons.layers_outlined, 
            onPressed: () => navigateTo( Fluroruter.categoriesRoute ),
            isActive: sideMenuProvider.currentPage == Fluroruter.categoriesRoute,
          ),
          MenuItem( text: 'Products', icon: Icons.dashboard_outlined, onPressed: () => {} ),
          MenuItem( text: 'Discount', icon: Icons.attach_money_outlined, onPressed: () => {} ),
          MenuItem( text: 'Customers', icon: Icons.people_alt_outlined, onPressed: () => {} ),
          
          const SizedBox( height: 30 ),
          
          const TextSeparator( text: 'UI Elements' ),
          MenuItem( 
            text: 'Icons', 
            icon: Icons.list_alt_outlined, 
            onPressed: () => navigateTo( Fluroruter.iconsRoute ),
            isActive: sideMenuProvider.currentPage == Fluroruter.iconsRoute,
          ),
          MenuItem( text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: () => {} ),
          MenuItem( text: 'Campaign', icon: Icons.note_add_outlined, onPressed: () => {} ),
          MenuItem( 
            text: 'Blank', 
            icon: Icons.post_add_outlined, 
            onPressed: () => navigateTo( Fluroruter.blankRoute ),
            isActive: sideMenuProvider.currentPage == Fluroruter.blankRoute,
          ),
          
          const SizedBox( height: 50 ),
          
          const TextSeparator( text: 'Exit' ),
          MenuItem( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                .logout();
            }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF092044),
          Color(0xFF092042),
        ]
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10
        )
      ]
    );
  }
}