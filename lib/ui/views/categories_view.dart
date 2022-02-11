import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/datatables/categories_datasource.dart';


class CategoriesView extends StatefulWidget {
  const CategoriesView({ Key? key }) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    
    final categorias = Provider.of<CategoriesProvider>(context).categorias;
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Categories view', style: CustomLabels.h1 ),
          const SizedBox( height: 10 ),
          
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Creado por')),
              DataColumn(label: Text('Acciones')),
            ], 
            source: CategoriesDTS( categorias, context ),
            header: const Text('Categorias disponibles', maxLines: 2,),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? PaginatedDataTable.defaultRowsPerPage;
              });  
            } ,
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: (){
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => CategoryModal( categoria: null)
                  );
                }, 
                text: 'Crear', 
                icon: Icons.add_outlined
              )
            ],
          )
        ],
      ),
    );
  }
}