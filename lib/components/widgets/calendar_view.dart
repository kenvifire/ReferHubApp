import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/screens/view_referral_screen.dart';
import 'package:ref_hub_app/models/referItem.dart';


class ReferItemTile extends StatelessWidget {
  final _sl = GetIt.instance;
  final ReferItem referItem;

  ReferItemTile({required this.referItem, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 80,
        child: Slidable(
          key: Key(referItem.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: false,
                onPressed: delete,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',

              ),
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              )
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      ViewReferralScreen())
              );
            },
            child: Ink(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(referItem.title),
                ],
              ),
            ),
          )
        ),
      );
  }
  void doNothing(BuildContext buildContext){}

  void delete(BuildContext buildContext) {

  }

}