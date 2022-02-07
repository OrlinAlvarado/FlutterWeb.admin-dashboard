import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Dashboard view', style: CustomLabels.h1 ),
        const SizedBox( height: 10 ),
        
        const WhiteCard(
          title: 'Sales Statistic',
          child: Text('Hola mundo')
        )
      ],
    );
  }
}