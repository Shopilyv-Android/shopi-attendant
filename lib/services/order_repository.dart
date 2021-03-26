import 'package:flutter/material.dart';
import 'package:shopi_attendant/models/orders.dart';
import  'package:http/http.dart' as http;
import 'dart:convert';

class OrderRepository{
  final String url_fetch_orders="https://shopilyv.com/shopiservice/fetch_orders_attendant.php";
  final String url_update_service="https://shopilyv.com/shopiservice/update_service.php";
  final String url_complete_orders="https://shopilyv.com/shopiservice/completeOrders.php";
  final String url_fetch_sales_by_id="https://shopilyv.com/shopiservice/sales_summary_by_id.php";
  final String url_fetch_served_by_id="https://shopilyv.com/shopiservice/getClientsTotal.php";
  final String url_fetch_count_completed="https://shopilyv.com/shopiservice/countCompletedOrders.php";

  OrderRepository(){

  }

  Future<List<Orders>> fetchOrdersById(String employee_id,String status) async{
    try{
      http.Response response=await http.post(
          url_fetch_orders,
          headers: {"Accept":"application/json"},
          body:{
            "employee_id":employee_id,
            "status":status
          }
      );

      var jsonOrders=jsonDecode(response.body);
      print(jsonOrders);
      var ordersMap=jsonOrders["orders"] as List;
      List<Orders> order_list=ordersMap.map<Orders>((x) => Orders.fromJson(x)).toList();
      print("The first item is " + order_list.first.order_date);

      return order_list;
    }

    catch(e,stacktrace){
      print(stacktrace);
      return null;
    }
  }

  Future<String> updateService(String status,String id) async{
    print("The status is " + status  + " and the id is " + id);
    http.Response response=await http.post(url_update_service,
    headers: {"Accept":"application/json"},
    body: {"status":status,"id":id});

    var result=response.body;
    String userResponse=result.toString();
    print("User response is " + userResponse);
    return userResponse;
  }

  Future<String> completeOrder(String status,String bill_no) async{
    http.Response response=await http.post(url_complete_orders,
    headers: {"Accept":"application/json"},
        body: {"status":status,"bill_no":bill_no}
    );

    var result=response.body;
    String userResponse=result.toString();
    return userResponse;
  }

  Future<String> fetchSalesById(String employee_id,String status) async{
    http.Response response=await http.post(url_fetch_sales_by_id,
      headers: {"Accept":"application/json"},
      body: {"employee_id":employee_id,"status":status}
    );

    var result=response.body;
    String userResponse=result.toString();
    return userResponse;

  }

  Future<String> fetchServedById(String employee_id,String status) async{
    http.Response response=await http.post(url_fetch_served_by_id,
    headers: {"Accept":"application/json"},
    body:{"employee_id":employee_id,"status":status}
    );

    var result=response.body;
    String userResponse=result.toString();
    return userResponse;
  }

  Future<String> countCompletedOrders(String employee_id,String status) async{
    http.Response response=await http.post(url_fetch_count_completed,
    headers: {"Accept":"application/json"},
    body:{"employee_id":employee_id,"status":status}
    );

    var result=response.body;
    String userResponse=result.toString();
    return userResponse;
  }

}