import 'services.dart';
class Cart{

  double total_amount;
  List<ServiceItem> services;

  Cart({this.total_amount,this.services});

  Map<String,dynamic> toJson()=>{
    'total_amount':this.total_amount,
    'services':List<dynamic>.from(services.map((x) => x.toJson()))
  };

  factory Cart.fromJson(Map<String,dynamic> parsedJson){
    List<ServiceItem> user_services;
    if(parsedJson["services"]!=null){
      user_services=parsedJson["services"].map((x)=>ServiceItem.fromJson(x));
    }
    else{
      user_services=[];
    }
    return Cart(
      total_amount: parsedJson['total_amount'],
      services:user_services
    );
  }

}

class ServiceItem{
  int id;
  String status;
  String service_time_started;
  String service_time_completed;
  String isCompleted;

  ServiceItem({this.status,this.service_time_started,this.service_time_completed,this.isCompleted});

  Map<String,dynamic> toJson()=>{
  'status':this.status,
  'service_time_started':this.service_time_started,
  'service_time_completed':this.service_time_completed,
  'isCompleted':this.isCompleted
  };

  factory ServiceItem.fromJson(Map<String,dynamic> parsedJson){
    return ServiceItem(
      status: parsedJson["status"],
      service_time_started: parsedJson["service_time_started"],
      service_time_completed: parsedJson["service_time_completed"],
      isCompleted: parsedJson["isCompleted"]
    );
  }

}