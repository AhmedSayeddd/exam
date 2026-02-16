import 'package:dio/dio.dart';
import 'package:exam/model/product.dart';

class ApiService {
  final String baseUrl = "https://www.jsonkeeper.com/b/QXODW";
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
