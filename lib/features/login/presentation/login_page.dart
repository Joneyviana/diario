import 'package:annotations/features/login/service/login_service.dart';
import 'package:annotations/presentation/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Login  extends StatefulWidget {
 Login({Key key}) : super(key: key);

  @override
   LoginState createState() =>  LoginState();
}

class LoginState extends State {
  LoginService loginService = new LoginService();
  final storage = new FlutterSecureStorage();


  void logar(){
    ///await loginService.loginWithGoogle();
    Navigator.pushNamed(context, '/note');
  }

  void redirect() async {
    bool signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
    if(signedIn){
      Navigator.pushNamed(context, '/note');  
    }
  }
  
  @override
  void initState()  {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       
       child: Center(child:GoogleSignInButton(onPressed: () async { 
            new Loading().onLoading(context,logar);
            })
          ),
       decoration: BoxDecoration(
         color:Colors.orangeAccent[100]
  ),
    );
  }
}
