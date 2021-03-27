import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ezparking/Services/Validation.dart';
// import 'package:ezparking/Boundary/SignUpPage.dart';
import 'package:ezparking/Boundary/LoginPage.dart';


String username,password,confpassword;
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController userNameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController confirmpasswordController = new TextEditingController();



class FormCard_signup extends StatelessWidget {

  static const Map <String,String> Pages = {'login':"Login", 'signup': "Sign Up"};

  String PageName;
  double Height;

  FormCard_signup(String page){
    this.PageName = Pages [page];
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,

        height: ScreenUtil.getInstance().setHeight((this.PageName == 'Login') ? 470 : 570),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    this.PageName,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontFamily: 'Poppins-Bold',
                      letterSpacing: .6,
                    )
                ),
                new TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(labelText: 'UserName',
                    icon: Icon(Icons.person),
                    suffixIcon:(true) ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){userNameController.clear();},) : null ,

                  ),
                  keyboardType: TextInputType.text,
                  validator: Validation().validatePassWord,

                  onSaved: (String value){
                    username = value;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'PassWord',
                    icon: Icon(Icons.lock),
                    suffixIcon:(true) ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){passwordController.clear();},) : null ,),
                  obscureText: true,
                  validator: Validation().validatePassWord,
                  onSaved: (String value)
                  {
                    password = value;
                  },
                ),

                TextFormField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(labelText: 'Confirm PassWord',
                    icon: Icon(Icons.lock),
                    suffixIcon:(true) ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){confirmpasswordController.clear();},) : null ,),
                  obscureText: true,
                  validator: Validation().validateConfirmPassWord,
                  onSaved: (String value)
                  {
                    confpassword = value;
                  },

                ),





              ],
            ),
          ),
        )
    );
  }

}