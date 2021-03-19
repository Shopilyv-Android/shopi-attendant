import "package:flutter/material.dart";
import "package:animations/animations.dart";
import 'package:google_fonts/google_fonts.dart';
import "package:shopi_attendant/pages/Dashboard.dart";
import "package:shopi_attendant/services/user_repository.dart";
import "package:shopi_attendant/models/user.dart";
import "package:shopi_attendant/models/validation.dart";

class LoginPage extends StatefulWidget{
  LoginPage({Key key}):super(key:key);

  @override
  LoginPageState createState()=> LoginPageState();
}

class LoginPageState extends State<LoginPage>{
 bool _obsecure=true;
 String email,password;
 Validation validation=new Validation();
 TextEditingController emailController=new TextEditingController();
 TextEditingController passwordController=new TextEditingController();
 UserRepository userRepository=new UserRepository();
 final GlobalKey<FormState> _regissterFormKey=GlobalKey<FormState>();
 bool loading_status=false;
 String error_message='';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.white,
      child:  Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade100,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 1/15,horizontal: 30.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1/2,
                          color: Theme.of(context).primaryColor,
                          child: Form(
                            key: _regissterFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 1/4,
                                    color: Theme.of(context).primaryColor,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                                          child: Container(
                                            //          width: MediaQuery.of(context).size.width * 0.80,
                                            height: MediaQuery.of(context).size.height * 0.08,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    "assets/images/logoshop.png",
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                                          child:  RichText(
                                            text: TextSpan(
                                              text: 'ShopiLyv ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.2,
                                                  fontSize: 25),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Attendant',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: GoogleFonts.lobster().fontFamily)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        //filled: true,
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                        hintText: "Your email Address",
                                        labelText: "E-mail"),
                                    controller: emailController,
                                    validator: validation.emailValidator,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (String keyed) {
                                      setState(() {
                                        email = keyed;
                                        print(email);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    obscureText: _obsecure,
                                    validator: validation.empty_field_validator,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.lock_open,
                                          color: Colors.white,
                                        ),
                                        border: UnderlineInputBorder(),
                                        hintText: "Password",
                                        labelText: "Password",
                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obsecure = !_obsecure;
                                              });
                                            },
                                            child: Icon(
                                              _obsecure ? Icons.visibility : Icons.visibility_off,
                                              color: _obsecure ? Colors.white : Colors.red,
                                            ))),
                                    onChanged: (String value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                  ),
                                ),
                                error_message.length > 0 ?
                                Padding(
                                  padding: EdgeInsets.symmetric(),
                                  child: Text(error_message,style: TextStyle(color: Colors.red.shade900),),
                                ): Container(),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: TextButton(onPressed:(){
                                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
                                      if(_regissterFormKey.currentState.validate()){
                                        setState(() {
                                          loading_status=true;
                                        });
                                        email=emailController.text;
                                        password=passwordController.text;
                                        print("email is " + email);
                                        print("password is " + password);
                                        getUser(email, password).then((value){
                                          if(value!=null){
                                            error_message='';
                                            loading_status=false;
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
                                          }
                                          else{
                                            setState(() {
                                              loading_status=false;
                                              error_message="Incorrect username or password";
                                            });
                                          }
                                        });
                                      }

                                    },
                                      child: Text("Sign in",style: TextStyle(color: Theme.of(context).primaryColor),),
                                      style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.white,
                                          onSurface: Theme.of(context).primaryColor,
                                          elevation: 5,
                                          //  side: BorderSide(),
                                          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))
                                      ),
                                    ),
                                  ),
                                ),
                                //RaisedButton()
                              ],
                            ),
                          )
                      )
                  ),
                ],
              )
          ),
          loading_status ?
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                    child:  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1/4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize:MainAxisSize.min ,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                            ),
                            Text("Please wait....",style: TextStyle(color: Theme.of(context).primaryColor,
                            fontSize: 16,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ): Container()
        ],
      )
    );
  }

 Future<User> getUser(String email,String password) async{
    User users=await userRepository.fetchUserById(email, password);
    return users;
 }
}