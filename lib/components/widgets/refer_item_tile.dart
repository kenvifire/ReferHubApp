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

  ReferItemTile({required this.referItem, required this.onDelete, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: 80,
          child: Slidable(

            key: Key(referItem.id),
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
                  onPressed: doNothing,
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
        ),
      );
  }
  void doNothing(BuildContext buildContext){}

  void delete(BuildContext buildContext) async {
    await _sl.get<ReferralService>().removeReferral(referItem);
    final controller = Slidable.of(buildContext);
    controller?.dismiss(ResizeRequest(const Duration(milliseconds: 300), () {

    }),
        duration: const Duration(milliseconds: 300));
    onDelete();
  }

}