import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:shopi_attendant/services/order_repository.dart";
import "package:shopi_attendant/models/orders.dart";
import 'package:shopi_attendant/models/user.dart';

class SalesSummary extends StatefulWidget{
  SalesSummary({Key key,@required this.user}):super(key:key);
  User user;

  @override
  SalesSummaryState createState()=> SalesSummaryState(user);
}

class SalesSummaryState extends State<SalesSummary>{
  Future<List<Orders>> future_orders;
  OrderRepository orderRepository=new OrderRepository();
  User user;

  SalesSummaryState(this.user);


  @override
  void initState() {
    future_orders=this.getOrdersById(user.id.toString(), '1');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: future_orders,
        builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
        List<Orders> user_orders=snapshot.data;
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:  ListView.builder(
                        itemCount: user_orders.length,
                        itemBuilder: (context,index){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1/7,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                              color: Colors.white,
                       //       borderRadius: BorderRadius.circular(radius)
                            ),
                            child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
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
                                    child: Text("Commission: Ksh " + calculateTotalCommision(user_orders.elementAt(index)).toString(),style: TextStyle(color: Colors.black54,fontSize: 13),),
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
                            )
                          );
                        }),
                  )
                ],
              ),
            )
        );
      }

      else if(snapshot.hasError){
        return Center(
          child: Text("Error loading data"),
        );
      }

      /*else if(snapshot.hasData==null){
        return Container();
      }*/

      else if(snapshot.connectionState==ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        );
      }

      else if(snapshot.connectionState==ConnectionState.done && snapshot.data==null){
        return Container();
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

  Future<List<Orders>> getOrdersById(String id,String status) async{
    List<Orders> orders=await orderRepository.fetchOrdersById(id,status);
    print(orders);
    return orders;
  }

  double calculateTotalCommision(Orders order){
    double final_commission=0.0;
    order.jobs.forEach((element) {
      final_commission=final_commission + element.pay;
    });

    return final_commission;
  }
}