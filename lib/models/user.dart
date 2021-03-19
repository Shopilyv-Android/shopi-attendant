import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class User with ChangeNotifier{
  int id;
  String name;
  String email;
  String phone;
  String location;
  String date;
  String lat;
  String lng;
  String type;
  int shop;

  User({this.id,this.name,this.email,this.phone,this.location,this.date,this.lat,this.lng,this.type,this.shop});

  Map<String,dynamic> toJson()=>{
    'name':this.name,
    'email':this.email,
    'phone':this.phone,
    'location':this.location,
    'date':this.date,
    'lat':this.lat,
    'lng':this.lng,
    'type':this.type,
    'shop':this.shop
  };

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
  //    id: int.parse(parsedJson['id']),
      name: parsedJson['name'],
      email: parsedJson['email'],
      phone: parsedJson['phone'],
      location: parsedJson['location'],
      date:parsedJson['date'],
      lat: parsedJson['lat'],
      lng:parsedJson['lng'],
      type: parsedJson['type'],
  //    shop: int.parse(parsedJson['shop'])
    );
  }
}