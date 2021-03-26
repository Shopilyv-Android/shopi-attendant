import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class User with ChangeNotifier{
  int id;
  String name;
  String email;
  String phone;
  String company_id;

  User({this.id,this.name,this.email,this.phone,this.company_id});

  Map<String,dynamic> toJson()=>{
    'name':this.name,
    'email':this.email,
    'phone':this.phone,
    'company_id':this.company_id

  };

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
      id: int.parse(parsedJson['id']),
      name: parsedJson['name'],
      email: parsedJson['email'],
      phone: parsedJson['phone'],
      company_id: parsedJson['company_id']

    );
  }
}