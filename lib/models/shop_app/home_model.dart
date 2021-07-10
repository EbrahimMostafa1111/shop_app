import 'package:flutter/material.dart';
class HomeModel{
  bool? status;
  HomeDataModel?  data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data= HomeDataModel.fromJson(json['data']);
  }

}
class HomeDataModel // here we need to add all maps in each list to collect the map of "data"
    {
  List<BannerModel>? banners=[];
  List<ProductModel>? products=[];

  HomeDataModel.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners?.add(BannerModel.fromJson(element)); //element is passing for each map to add it to the list
    });
    json['products'].forEach((element){
      products?.add( ProductModel.fromJson(element));
    });
  }
}
class BannerModel // this model for one map of banner list
    {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel // this model for one map of product list
    {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;


  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}