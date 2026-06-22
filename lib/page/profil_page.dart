import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'login_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  static const Color primaryColor = Color(0xFF6B1A2A);
  static const Color textColor = Color(0xFF3D0C14);
  static const Color subtleText = Color(0xFF8B5E6B);

  // Menyimpan data profile di State agar dapat diubah secara dinamis
  late String userName;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    userName = UserModel.currentUser?.nama ?? "";
    userEmail = UserModel.currentUser?.email ?? "";
  }

  // ─────────────────────────────────────────────
  //  1. Dialog Edit Profil
  // ─────────────────────────────────────────────
  void _showEditProfilDialog(BuildContext context) {
    final nameCtrl = TextEditingController(text: userName);
    final emailCtrl = TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Edit Profil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Alamat Email",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: subtleText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(80, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty) {
                setState(() {
                  userName = nameCtrl.text;
                  userEmail = emailCtrl.text;
                  if (UserModel.currentUser != null) {
                    UserModel.currentUser = UserModel(
                      id: UserModel.currentUser!.id,
                      nama: userName,
                      email: userEmail,
                      token: UserModel.currentUser!.token,
                    );
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Profil berhasil diperbarui",
                      style: TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  2. Dialog Ubah Password
  // ─────────────────────────────────────────────
  void _showUbahPasswordDialog(BuildContext context) {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Ubah Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPassCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password Lama",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPassCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password Baru",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPassCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password Baru",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: subtleText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(80, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: () {
              if (oldPassCtrl.text.isEmpty ||
                  newPassCtrl.text.isEmpty ||
                  confirmPassCtrl.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Lengkapi semua kolom password"),
                    backgroundColor: primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
                return;
              }
              if (newPassCtrl.text != confirmPassCtrl.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Konfirmasi password baru tidak cocok"),
                    backgroundColor: primaryColor,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
                return;
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Password berhasil diubah"),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text("Ubah"),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  3. Dialog Pusat Bantuan
  // ─────────────────────────────────────────────
  void _showBantuanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Pusat Bantuan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Bagaimana cara memesan produk?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: textColor),
                ),
                subtitle: Text(
                  "Pilih produk di tab Home, masukkan ke keranjang, isi data penerima di tab Checkout, lalu buat pesanan.",
                  style: TextStyle(fontSize: 12.5, color: subtleText),
                ),
              ),
              Divider(color: Color(0xFFD4A0A8)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Di mana melihat status pesanan?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: textColor),
                ),
                subtitle: Text(
                  "Status pesanan Anda (Pending, Diproses, Dikirim, Selesai) dapat dipantau secara langsung di tab Pesanan.",
                  style: TextStyle(fontSize: 12.5, color: subtleText),
                ),
              ),
              Divider(color: Color(0xFFD4A0A8)),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Hubungi Hub Layanan Kami",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5, color: textColor),
                ),
                subtitle: Text(
                  "Jika terdapat kendala inventori, hubungi admin di email: support@payunggeulis.com",
                  style: TextStyle(fontSize: 12.5, color: subtleText),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  4. Konfirmasi Logout
  // ─────────────────────────────────────────────
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFBF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          "Konfirmasi Keluar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari akun ini?",
          style: TextStyle(color: subtleText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: subtleText)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE57373),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              UserModel.currentUser = null; // Clear session
              // Redirect ke Login & bersihkan tumpukan navigasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("Keluar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profil Saya",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// FOTO PROFIL
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD4A0A8),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.12),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFFFFBF0),
                  child: Icon(
                    Icons.person_rounded,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// NAMA USER (Dinamis dari state)
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 6),

              /// EMAIL USER (Dinamis dari state)
              Text(
                userEmail,
                style: const TextStyle(
                  color: subtleText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 35),

              /// MENU
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4A0A8),
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xFFBCAAA4),
                      ),
                      onTap: () => _showEditProfilDialog(context),
                    ),
                    const Divider(height: 1, color: Color(0xFFD4A0A8)),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4A0A8),
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        "Ubah Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xFFBCAAA4),
                      ),
                      onTap: () => _showUbahPasswordDialog(context),
                    ),
                    const Divider(height: 1, color: Color(0xFFD4A0A8)),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBF0),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4A0A8),
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.help_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        "Bantuan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xFFBCAAA4),
                      ),
                      onTap: () => _showBantuanDialog(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              /// LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE57373),
                    side: const BorderSide(
                      color: Color(0xFFFFC5C5),
                      width: 1.5,
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      52,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => _showLogoutConfirmation(context),
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
