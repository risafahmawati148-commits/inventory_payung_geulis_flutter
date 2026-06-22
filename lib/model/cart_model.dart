class CartModel {
  int id;
  String namaProduk;
  String gambar;
  String deskripsi;
  int harga;
  int qty;

  CartModel({
    required this.id,
    required this.namaProduk,
    required this.gambar,
    required this.deskripsi,
    required this.harga,
    required this.qty,
  });
}
