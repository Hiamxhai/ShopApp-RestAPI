import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:store_app/consts/api_const.dart';
import 'package:store_app/model/categories_model.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/model/users_model.dart';

class APIHandler {
    static Future<List<dynamic>> getData ({required String target, String? limit,}) async {
      // https://api.escuelajs.co/api/v1/products?offset=0&limit=10
     try {
       var uri = Uri.https(BASE_URL , '/api/v1/$target',
           target == "products" ? {
              "offset" : "0",
              "limit": limit
           } : {}
           );
       // Dung Get de call api
       var response =
       await http.get(uri);
       //print("response ${jsonDecode(response.body)}");
       var data =jsonDecode(response.body);
       List tempList = [];
       if(response.statusCode != 200) {
         throw data["message"];
       }
       for(var v in data) {
         tempList.add(v);
         // print('V $v \n\n');
       }
       return tempList;
     }
     catch (error) {
       print('An error occured $error');
       throw error.toString();
     }
    }

    static Future<List<ProductsModel>> getAllProduct ({required String limit}) async {
    List temp = await getData(target: "products", limit: limit);
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getAllCategories () async {
    List temp = await getData(target: "categories");
    return CategoriesModel.categoryFromSnapshot(temp);
  }
  static Future<List<UsersModel>> getALlUsers () async {
      List temp = await getData(target: 'users');
      return UsersModel.usersSnapshot(temp);
  }

    static Future<ProductsModel> getProductbyID ({required String id}) async {
     try {
       var uri = Uri.https(BASE_URL , '/api/v1/products/$id',);
       // Dung Get de call api
       var response =
       await http.get(uri);
       //print("response ${jsonDecode(response.body)}");
       var data =jsonDecode(response.body);
       if(response.statusCode != 200) {
         throw data["message"];
       }

       return ProductsModel.fromJson(data);
     }
     catch (e) {
       print('An error occured $e');
       throw e.toString();
     }
    }

}

