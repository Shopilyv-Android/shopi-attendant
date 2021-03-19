import 'services.dart';
class Orders{
  int id;
  String order_id;
  String order_date;
  List<Job> jobs;
  String status;
  String time;
  String employee_name;
  double amount;

  Orders({this.order_id,this.order_date,this.jobs,this.status,this.employee_name,this.time,this.amount});

  Map<String,dynamic> toJson()=>{
    'order':this.order_id,
    'date':this.order_date,
    'agent':this.employee_name,
    'time':this.time,
    'amount':this.amount.toString(),
    'status':this.status,
    'jobs':List<dynamic>.from(jobs.map((x)=>x.toJson()))
  };

  factory Orders.fromJson(Map<String,dynamic> parsedJson){
    List<Job> user_services;
    if(parsedJson["jobs"]!=null){
      user_services=List<Job>.from(parsedJson["jobs"].map((x)=> Job.fromJson(x))).toList();
    }

    else{
      user_services=[];
    }
    return Orders(
      order_id: parsedJson['order'],
      order_date: parsedJson['date'],
      employee_name:parsedJson['agent'],
      status: parsedJson['status'],
      time: parsedJson['time'],
      amount: double.parse(parsedJson['amount']),
      jobs: user_services
    );
  }

  bool isCompleted(){
    bool completed_order=true;
    for(int i=0;i<jobs.length;i++){
      if(jobs.elementAt(i).status==0){
        completed_order=false;
      }
    }

    return completed_order;
  }
}