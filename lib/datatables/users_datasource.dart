import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/usuario.dart';


class UsersDTS extends DataTableSource{
  final List<Usuario> usuarios;
  UsersDTS(this.usuarios);
  
  @override
  DataRow getRow(int index) {
    final usuario = usuarios[index];
    
    final image = Image( image: AssetImage('no-image.jpg'), width: 35, height: 35);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          ClipOval(
            child: image,
          )
        ),
        DataCell(Text( usuario.nombre )),
        DataCell(Text( usuario.correo )),
        DataCell(Text( usuario.uid )),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon( Icons.edit_outlined),
                onPressed: (){
                  NavigationService.replaceTo( Fluroruter.userRoute.replaceFirst(':uid', usuario.uid) );
                }, 
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => usuarios.length;

  @override
  int get selectedRowCount => 0;
  
}