class Api {
  static const String baseUrl = "http://localhost:8000";

  /*
  |--------------------------------------------------------------------------
  | AUTH
  |--------------------------------------------------------------------------
  */

  static const String register = "$baseUrl/api/register";

  static const String login = "$baseUrl/api/login";

  /*
  |--------------------------------------------------------------------------
  | PRODUK
  |--------------------------------------------------------------------------
  */

  static const String produk = "$baseUrl/api/produk-customer";

  /*
  |--------------------------------------------------------------------------
  | PESANAN
  |--------------------------------------------------------------------------
  */

  static const String checkout = "$baseUrl/api/checkout";

  static const String pesanan = "$baseUrl/api/pesanan-customer";
}

String getFullImageUrl(String? path) {
  if (path == null || path.isEmpty) {
    return "";
  }
  if (path.startsWith("http://") || path.startsWith("https://")) {
    return path;
  }
  if (path.startsWith("produk_customer/")) {
    return "${Api.baseUrl}/storage/$path";
  }
  return "${Api.baseUrl}/$path";
}
