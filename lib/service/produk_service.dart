import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';

class ProdukService {
  static Future<List<dynamic>> getProduk() async {
    final response = await http.get(
      Uri.parse(Api.produk),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }
}
