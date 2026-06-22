import 'dart:convert';

import 'package:http/http.dart' as http;
import '../config/api.dart';

class PesananService {
  /*
  |--------------------------------------------------------------------------
  | Checkout
  |--------------------------------------------------------------------------
  */

  static Future<bool> checkout({
    required String namaCustomer,
    required String produk,
    required int jumlah,
    required int totalHarga,
    required String alamat,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Api.checkout),
        body: {
          "nama_customer": namaCustomer,
          "produk": produk,
          "jumlah": jumlah.toString(),
          "total_harga": totalHarga.toString(),
          "alamat": alamat,
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      print(e);

      return false;
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Ambil Pesanan
  |--------------------------------------------------------------------------
  */

  static Future<List> getPesanan({String email = ""}) async {
    try {
      final response = await http.get(
        Uri.parse("${Api.pesanan}?email=$email"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        );

        return data["data"];
      }

      return [];
    } catch (e) {
      print(e);

      return [];
    }
  }
}

