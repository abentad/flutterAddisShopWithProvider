import 'dart:convert';
import 'dart:io';

import 'package:ShoppingAppWithProvider/models/httpResponse.dart';
import 'package:ShoppingAppWithProvider/models/product.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<HTTPResponse<List<Product>>> getProducts() async {
    String url = 'https://fakestoreapi.com/products';
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Product> productsList = [];
        productsList = body.map<Product>((e) => Product.fromJson(e)).toList();
        return HTTPResponse(true, productsList,
            message: "success", responseCode: response.statusCode);
      } else {
        return HTTPResponse(false, null,
            message: "Invalid Response recieved.",
            responseCode: response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, null, message: "Unable to reach the internet");
    } on FormatException {
      return HTTPResponse(false, null, message: "Invalid response recieved.");
    } catch (e) {
      print(e);
      return HTTPResponse(false, null, message: "Something went wrong.");
    }
  }
}
