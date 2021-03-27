import 'package:flutter/material.dart';
import 'package:ezparking/Services/Validation.dart';

class Popwindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // print (list);

  Widget Popupwindow(BuildContext context, String mode, bool status) {
    var list = Validation().GetStatus(mode, status);
    print('var list = Validation().GetStatus(mode, status);');
    print(status);
    // var list = {'mode': 'Login', 'title': 'Sorry', 'body': 'Login unsuccessful, Try again !'};

    return new AlertDialog(
      title: Text(list['title']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(list['body']),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            (list['mode'] == 'login') ? null : Navigator.of(context).pop();
            Navigator.of(context).pop();
            print(status);
            print("list['mode'] is :");
            print(list['mode']);
            (status == true) ? print("TRUE") : print("FALSE");
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
