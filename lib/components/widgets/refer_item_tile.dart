import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/screens/edit_referral_screen.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/referral_service.dart';

import '../../services/user_service.dart';

class ReferItemTile extends StatefulWidget {
  ReferItemTile({required this.referItem, required this.onDelete, required this.onShare, Key? key}): super(key: key);
  final ReferItem referItem;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  @override
  State<ReferItemTile> createState() => _ReferItemTileState();
}

class _ReferItemTileState extends State<ReferItemTile> {
  final _sl = GetIt.instance;
  late bool isFavourite;
  late final String uid;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.referItem.isFavourite;
    uid = _sl.get<UserService>().getUser()!.uid;
  }

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
          key: Key(widget.referItem.id!),
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
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Text(widget.referItem.title),
                  subtitle: Text(widget.referItem.desc ?? ""),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditReferralScreen(item: widget.referItem,)));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  uid == widget.referItem.uid ? Container() : IconButton(
                    icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border, color: Colors.redAccent,),
                    onPressed: () {
                      if(!isFavourite) {
                        _sl.get<ReferralService>().addToFavourite(widget.referItem.id!);
                      } else {
                        _sl.get<ReferralService>().removeFromFavourite(widget.referItem.id!);
                      }
                      setState(() {
                        isFavourite = !isFavourite;
                      });

                    },
                  ),

                ],
              )
            ],
          ),
        ),
        ),
      );
  }
  void doShare(BuildContext buildContext){
    widget.onShare();
  }

  void delete(BuildContext buildContext) async {
    await _sl.get<ReferralService>().removeReferral(widget.referItem);
    final controller = Slidable.of(buildContext);
    controller?.dismiss(ResizeRequest(const Duration(milliseconds: 300), () {

    }),
        duration: const Duration(milliseconds: 300));
    widget.onDelete();
  }

}