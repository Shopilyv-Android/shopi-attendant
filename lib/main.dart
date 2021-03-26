import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopi_attendant/pages/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:shopi_attendant/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>User(id:0,name:'',email: '',phone: '',company_id: ''))
  ],
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
        );
      },
      theme: ThemeData(
          primaryColor: Color(0xff2d768c),
          fontFamily: GoogleFonts.varelaRound().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.varelaRoundTextTheme()),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return LoginPage();
  }
}

/**
 * Text(
    '',
    style: Theme.of(context).textTheme.headline4,
    ),
 * **/
