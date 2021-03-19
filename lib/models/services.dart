
class Job{
  int id;
  int service_id;
  String service_name;
  String service_amount;
  int status;
  String commission;
  double pay;
  String hours;
  String minutes;
  //String average_time;


  Job({this.id,this.service_id,this.service_name,this.service_amount,this.status,this.commission,this.pay,this.hours,
  this.minutes});

  Map<String,dynamic> toJson()=>{
    'name':this.service_name,
    'price':this.service_amount,
    'status':this.status.toString(),
    'commission_id':this.commission,
    'hours':this.hours,
    'minutes':this.minutes

  //  'average_time':this.average_time,
  };

  factory Job.fromJson(Map<String,dynamic> parsedJson){
    return Job(
      id: int.parse(parsedJson['new_id']),
      service_id: int.parse(parsedJson['id']),
      service_name: parsedJson["name"],
      service_amount:parsedJson["amount"],
      status:int.parse(parsedJson['status']),
      commission: parsedJson['commission'],
      pay: double.parse(parsedJson['pay']),
      hours: parsedJson['hours'],
      minutes: parsedJson['minutes']
    //  average_time: parsedJson["average_time"],
    );
  }

}