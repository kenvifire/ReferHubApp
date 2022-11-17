import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  errorText: 'Please enter your password',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

final String referral = 'referral';

shareModalBottomSheet(context) {
  showModalBottomSheet(context: context, builder: (BuildContext bc) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .20,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Share to"),
              Spacer(),
              IconButton(
                icon: Icon(Icons.cancel, color: Colors.orange, size: 25,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          Text("Sms"),
          IconButton(icon: Icon(Icons.sms, color: Colors.grey, size: 25,),
            onPressed: () {
              SocialShare.shareSms("message");
            },
          )
        ],
      ),
    );
  });
}
