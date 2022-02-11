
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({ Key? key, required this.child }) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
      vsync: this, 
      duration: const Duration( milliseconds: 300)
    );
  }
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              //TODO: Esto depende si es mas de 700px
              if( size.width > 700)
                const Sidebar(),
              
              //Contenedor de nuestro View
              Expanded(
                  child: Column(
                    children: [
                      //Navbar
                      const Navbar(),
                      
                      //View
                      Expanded(
                          child: widget.child,
                      )    
                    ],
                  ),
              )
              
            ],
          ),
           if( size.width < 700)
              AnimatedBuilder(
                animation: SideMenuProvider.menuController, 
                builder: (context, _) => Stack(
                  children: [
                    
                    
                    //TODO: Background
                    if(SideMenuProvider.isOpen)
                      Opacity(
                        opacity: SideMenuProvider.opacity.value,
                        child: GestureDetector(
                          onTap: () => SideMenuProvider.closeMenu(),
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    
                    Transform.translate(
                      offset: Offset( SideMenuProvider.movement.value, 0),
                      child: const Sidebar(),
                    )
                  ],
                )
              )
        ],
      )
    );
  }
}