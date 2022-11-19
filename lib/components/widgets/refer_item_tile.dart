import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/screens/edit_referral_screen.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/referral_service.dart';


class ReferItemTile extends StatelessWidget {
  final _sl = GetIt.instance;
  final ReferItem referItem;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  ReferItemTile({required this.referItem, required this.onDelete, required this.onShare, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 4.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white54
        ),
        child: Slidable(
          key: Key(referItem.id!),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
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
                onPressed: doShare,
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              )
            ],
          ),
        child: ListTile(
            title: Text(referItem.title),
            subtitle: Text(referItem.desc ?? ""),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditReferralScreen(item: this.referItem,)));
            }),
        ),
      );
  }
  void doShare(BuildContext buildContext){
    onShare();
  }

  void delete(BuildContext buildContext) async {
    await _sl.get<ReferralService>().removeReferral(referItem);
    final controller = Slidable.of(buildContext);
    controller?.dismiss(ResizeRequest(const Duration(milliseconds: 300), () {

    }),
        duration: const Duration(milliseconds: 300));
    onDelete();
  }

}