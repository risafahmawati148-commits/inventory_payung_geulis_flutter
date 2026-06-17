class Produk {
  final int id;
  final String namaProduk;
  final String deskripsi;
  final int harga;
  final int stok;
  final String gambar;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.gambar,
  });

  factory Produk.fromJson(
    Map<String, dynamic> json,
  ) {
    return Produk(
      id: json["id"] ?? 0,
      namaProduk: json["nama_produk"] ?? "",
      deskripsi: json["deskripsi"] ?? "",
      harga: int.tryParse(json["harga"].toString()) ?? 0,
      stok: int.tryParse(json["stok"].toString()) ?? 0,
      gambar: json["gambar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_produk": namaProduk,
      "deskripsi": deskripsi,
      "harga": harga,
      "stok": stok,
      "gambar": gambar,
    };
  }
}
