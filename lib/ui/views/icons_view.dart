import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  const IconsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Icons', style: CustomLabels.h1 ),
        const SizedBox( height: 10 ),
        
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          children: const [
            WhiteCard(
              title: 'ac_unit_outlined',
              child: Center( child: Icon( Icons.ac_unit_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'access_alarm_outlined',
              child: Center( child: Icon( Icons.access_alarm_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'account_balance_wallet_outlined',
              child: Center( child: Icon( Icons.account_balance_wallet_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'outbond_outlined',
              child: Center( child: Icon( Icons.outbond_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'accessible_forward_outlined',
              child: Center( child: Icon( Icons.accessible_forward_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'account_circle_outlined',
              child: Center( child: Icon( Icons.account_circle_outlined)),
              width: 170
            ),
            WhiteCard(
              title: 'account_tree_outlined',
              child: Center( child: Icon( Icons.account_tree_outlined)),
              width: 170
            ),
          ],
        )
        
      ],
    );
  }
}