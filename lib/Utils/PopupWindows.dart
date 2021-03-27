import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Boundary/LoginPage.dart';
import 'package:ezparking/Services/Validation.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:ezparking/Boundary/MapPage.dart';

//
// class Popupwindow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return Container();
//   }
//   Widget PopupDialog(BuildContext context, String mode, bool status) {
//
//     // var list = Validation().GetStatus(mode, status);
//     var list = {'mode': 'Login', 'title': 'Sorry', 'body': 'Login unsuccessful, Try again !'};
//     print (list);
//     return new AlertDialog(
//       title:  Text( list['title']),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(list['body']),
//         ],
//       ),
//       actions: <Widget>[
//         new FlatButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//             print (status);
//             (status == true && list['mode']== 'Login' )?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MapPage( auth: Auth() ))) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage( auth: Auth(), )));
//             print ("list['mode'] is :");
//             print (list['mode']);
//             // (status == true && list['mode']== 'Login' )?  Navigator.of(context).pushNamedAndRemoveUntil(MapPage.routeName,(Route<dynamic> route) => true) : Navigator.of(context).pushNamedAndRemoveUntil(MapPage.routeName,(Route<dynamic> route) => true)  ;
//             (status == true )? print ("TRUE"):print ("FALSE");
//           },
//           textColor: Theme.of(context).primaryColor,
//           child: const Text('Okay'),
//         ),
//       ],
//     );
//   }
//   Widget horizontalLine() => Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16.0),
//     child: Container(
//       width: ScreenUtil.getInstance().setWidth(120),
//       height: 1.0,
//       color: Colors.black26.withOpacity(.2),
//     ),
//   );
//
// }
//
//
//
//


class Popwindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  // print (list);

  Widget Popupwindow(BuildContext context,String mode, bool status) {

    var list = Validation().GetStatus(mode, status);
    print ('var list = Validation().GetStatus(mode, status);');
    print (status);
    // var list = {'mode': 'Login', 'title': 'Sorry', 'body': 'Login unsuccessful, Try again !'};

    return new AlertDialog(
      title:  Text( list['title']),
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

            ( list['mode'] == 'login')? null: Navigator.of(context).pop() ;
            Navigator.of(context).pop();

            // Navigator.of(context).pop();
            print (status);
            // (status == true && list['mode']== 'Login' )?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MapPage( auth: Auth() ))) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage( auth: Auth(), )));
            print ("list['mode'] is :");
            print (list['mode']);
            // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => LoginPage(auth: Auth(),)));
            // new LoginPage(auth: Auth(),);
            // Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            // (status == true && list['mode']== 'Login' )?  Navigator.of(context).pushNamedAndRemoveUntil(MapPage.routeName,(Route<dynamic> route) => true) : Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName,(Route<dynamic> route) => true)  ;
            (status == true )? print ("TRUE"):print ("FALSE");

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}