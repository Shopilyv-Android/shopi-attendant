import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:shopi_attendant/models/services.dart';
import 'dart:math';
import 'package:shopi_attendant/services/order_repository.dart';
import 'package:shopi_attendant/models/orders.dart';
import 'package:shopi_attendant/models/user.dart';

class Commissions extends StatefulWidget{
  Commissions({Key key,@required this.user}):super(key:key);
  User user;

  @override
  CommissionState createState()=> CommissionState(this.user);
}

class CommissionState extends State<Commissions>  with TickerProviderStateMixin {

  Animation arrow_animation;
  AnimationController arrow_animation_controller;
  bool commission_expanded=false;
  OrderRepository orderRepository=new OrderRepository();
  Future<String> future_sales,future_served,future_orders_completed;
  Future<List<Orders>> future_total_commissions;
  User user;

  CommissionState(this.user);

  @override
  void initState() {
    future_sales=this.getSalesById(user.id.toString(), "1");
    future_served=this.getServedById(user.id.toString(), "1");
    future_orders_completed=this.getOrdersCompleted(user.id.toString(),"1");
    future_total_commissions=this.getOrdersById(user.id.toString(), "1");
    super.initState();
    arrow_animation_controller=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    arrow_animation=Tween(begin: 0.0,end:pi).animate(arrow_animation_controller);
    arrow_animation_controller.addStatusListener((status) {
      if(status==AnimationStatus.forward){
        setState(() {
          commission_expanded=true;
        });
      }

      else if(status==AnimationStatus.reverse){
        setState(() {
          commission_expanded=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  FutureBuilder(
      //,future_total_commissions
        future: Future.wait([future_sales,future_served,future_orders_completed,future_total_commissions]),
        builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData && snapshot.data[3]!=null){
            String sales_total=snapshot.data[0];
            String customers_served=snapshot.data[1];
            String orders_completed=snapshot.data[2];
            List<Orders> user_orders=snapshot.data[3];
            double user_total_commissions=calculateCommissions(user_orders);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
              child: Container(
                width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                      //    curve: Curves.bounceInOut,
                          width: MediaQuery.of(context).size.width,
                          height: commission_expanded ?
                          MediaQuery.of(context).size.height * 3/4 :
                          MediaQuery.of(context).size.height * 1/3,
                          //  color: Colors.white,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(1.0,1.0),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.black12
                                )
                              ]
                          ),
                          child: Column(
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                child: Row(
                                  children: [

                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 50.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monetization_on,color:Theme.of(context).primaryColor,size: 60,),
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Ksh " + user_total_commissions.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24),),
                                            Text("Commmissions",style: TextStyle(color: Colors.black54,fontSize: 12),)
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text("Ksh " + sales_total,style: TextStyle(color: Theme.of(context).primaryColor),),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text("Sales",style: TextStyle(color: Colors.black54,fontSize: 12),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text(customers_served,style: TextStyle(color: Colors.amber),),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text("Customers Served",style: TextStyle(color: Colors.black54,
                                                          fontSize: 12),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text((double.parse(orders_completed)).toInt().toString() + "%",style: TextStyle(color:Colors.greenAccent),),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Text("Orders Completed",style: TextStyle(color: Colors.black54,
                                                          fontSize: 12),),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                          child: Container(
                                            //     duration: Duration(milliseconds: 500),
                                            width: MediaQuery.of(context).size.width,
                                            height: commission_expanded ?  MediaQuery.of(context).size.height * .5 : 0,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height * 2/5,
                                                    child: ListView.builder(
                                                      itemCount: user_orders.length,
                                                      itemBuilder: (context,index){
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          height: MediaQuery.of(context).size.height * 1/8,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text(user_orders.elementAt(index).order_id,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                                                                          fontSize: 15),),
                                                                      Text(user_orders.elementAt(index).order_date.substring(0,10),style: TextStyle(color: Colors.black54,fontSize: 13,
                                                                      ),)
                                                                    ],
                                                                  )
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Text("Average time: 30 minutes",style: TextStyle(color: Colors.black54,
                                                                    fontSize: 13),),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Text("Commission: Ksh " + calculateCommisionPerOrder(
                                                                    user_orders.elementAt(index)
                                                                ).toString() ,style: TextStyle(color: Colors.black54,fontSize: 13),),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Text("Time: " + user_orders.elementAt(index).order_date.substring(11,19) ,style: TextStyle(color: Colors.black54,fontSize: 13),),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Text("Status:",style: TextStyle(color: Colors.black54,fontSize: 13),),
                                                                          Text("Completed",style: TextStyle(color: Theme.of(context).primaryColor,
                                                                              fontSize: 13),)
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                      child: Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor,),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                            child: AnimatedBuilder(
                                                animation: arrow_animation_controller,
                                                builder: (context,child)=>Transform.rotate(
                                                  angle: arrow_animation.value,
                                                  child:IconButton(icon: Icon(Icons.keyboard_arrow_down_sharp,size: 40,),
                                                    onPressed: (){
                                                      arrow_animation_controller.isCompleted ?
                                                      arrow_animation_controller.reverse() :
                                                      arrow_animation_controller.forward();
                                                    },),
                                                )
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      /* Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceInOut,
                    width: MediaQuery.of(context).size.width,
                    height: commission_expanded ?
                    MediaQuery.of(context).size.height * 3/4 :
                    MediaQuery.of(context).size.height * 1/5,
                    //  color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(1.0,1.0),
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                              color: Colors.black12
                          )
                        ]
                    ),
                    child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                          child: Row(
                            children: [

                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on,color:Theme.of(context).primaryColor,size: 60,),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Ksh 24000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24),),
                                      Text("Commmissions",style: TextStyle(color: Colors.black54,fontSize: 12),)
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                              child: Column(
                                children: [
                                  Divider(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("Ksh 25000",style: TextStyle(color: Theme.of(context).primaryColor),),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("Sales",style: TextStyle(color: Colors.black54,fontSize: 12),),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("20",style: TextStyle(color: Colors.amber),),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("Customers Served",style: TextStyle(color: Colors.black54,
                                                    fontSize: 12),),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("100%",style: TextStyle(color:Colors.greenAccent),),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                child: Text("Orders Completed",style: TextStyle(color: Colors.black54,
                                                    fontSize: 12),),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                    child: Container(
                                      //     duration: Duration(milliseconds: 500),
                                      width: MediaQuery.of(context).size.width,
                                      height: commission_expanded ?  MediaQuery.of(context).size.height * .5 : 0,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 2/5,
                                              child: ListView.builder(
                                                itemCount: 10,
                                                itemBuilder: (context,index){
                                                  return Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height * 1/10,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text("Kinyozi",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                                                                    fontSize: 15),),
                                                                Text("21/02/2021",style: TextStyle(color: Colors.black54,fontSize: 13,
                                                                ),)
                                                              ],
                                                            )
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Text("Average time: 30 minutes",style: TextStyle(color: Colors.black54,
                                                              fontSize: 13),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Text("Commission: sh 200",style: TextStyle(color: Colors.black54,fontSize: 13),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Row(
                                                                  children: [
                                                                    Text("Status:",style: TextStyle(color: Colors.black54,fontSize: 13),),
                                                                    Text("Completed",style: TextStyle(color: Theme.of(context).primaryColor,
                                                                        fontSize: 13),)
                                                                  ],
                                                                ),
                                                              ),

                                                              Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                                child: Icon(Icons.check_circle_outline,color: Theme.of(context).primaryColor,),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider()
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          /* Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                    child: Row(
                                      children: [
                                        Text("Total:Ksh 24000",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16),)
                                      ],
                                    ),
                                  )*/
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                      child: AnimatedBuilder(
                                          animation: arrow_animation_controller,
                                          builder: (context,child)=>Transform.rotate(
                                            angle: arrow_animation.value,
                                            child:IconButton(icon: Icon(Icons.keyboard_arrow_down_sharp,size: 40,),
                                              onPressed: (){
                                                arrow_animation_controller.isCompleted ?
                                                arrow_animation_controller.reverse() :
                                                arrow_animation_controller.forward();
                                              },),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )*/

                    ],
                  ),
                )
              )
            );
          }

          else if(snapshot.hasError){
            return Center(
                child: Text('Error loading data')
            );

          }

          else if(snapshot.connectionState==ConnectionState.done && snapshot.data[3]==null){
            return Container();
          }

          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            );
          }

          else{
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            );
          }
        });
  }

  Future<String> getSalesById(String employee_id,String status) async{
    String user_sales=await orderRepository.fetchSalesById(employee_id, status);
    return user_sales;
  }

  Future<String> getServedById(String employee_id,String status) async{
    String user_sales=await orderRepository.fetchServedById(employee_id, status);
    return user_sales;
  }

  Future<String> getOrdersCompleted(String employee_id,String status) async{
    String user_sales=await orderRepository.countCompletedOrders(employee_id, status);
    return user_sales;
  }

  Future<List<Orders>> getOrdersById(String id,String status) async{
    List<Orders> orders=await orderRepository.fetchOrdersById(id,status);
    print(orders);
    return orders;
  }

 double calculateCommissions(List<Orders> orders){
    double order_commission=0.0;
    orders.forEach((element) {
      double jobs_commission=0.0;
      element.jobs.forEach((element1) {
        jobs_commission=jobs_commission + element1.pay;
      });
      order_commission=order_commission + jobs_commission;
    });

    return order_commission;
  }
  double calculateCommisionPerOrder(Orders order){
    double final_commission=0.0;
    order.jobs.forEach((element) {
      final_commission=final_commission + element.pay;
    });

    return final_commission;
  }
}