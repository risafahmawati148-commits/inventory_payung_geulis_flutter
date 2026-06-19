class Api {
  // === CONFIGURASI IP LARAVEL ===
  // 1. Jika running di Web (Chrome) / Windows: "http://localhost:8000"
  // 2. Jika running di Android Emulator (AVD): "http://10.0.2.2:8000"
  // 3. Jika running di HP Fisik (satu jaringan Wi-Fi): "http://192.168.100.102:8000"
  //    (PENTING: Jika menggunakan HP Fisik, jalankan Laravel dengan: php artisan serve --host=0.0.0.0)
  
  static const String baseUrl = "http://192.168.100.102:8000"; // Silakan sesuaikan dengan target running Anda

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
