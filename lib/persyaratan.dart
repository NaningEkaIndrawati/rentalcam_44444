import 'package:flutter/material.dart';

class TermsAndConditions {
  String title;
  String content;

  TermsAndConditions({required this.title, required this.content});
}

class PersyaratanPage extends StatelessWidget {
  final List<TermsAndConditions> termsAndConditions = [
    TermsAndConditions(
      title: "Syarat & Ketentuan",
      content: """
  1. Menunjukkan beberapa identitas penyewa
  2. Meninggalkan 1 kartu identitas yang terdapat foto penyewa
  3. Durasi penyewa sudah disepakati di awal, jika ada perpanjangan sewa yang dikomunikasikan secara online di tengah persewaan berjalan maka di anggap tindakan kriminal rumah rental camera akan melaporkannya ke pihak berwajib
  4. Perpanjangan sewa hanya bisa disepakati dengan cara penyewa mendatangi kantor dengan membawa unit yang disewa dan membayar lunas penyewaan yang sudah berjalan
      """,
    ),
    TermsAndConditions(
      title: "Jenis - Jenis Identitas",
      content:
          "- E-KTP*               - Kartu Pelajar         - Akte Kelahiran\n- SIM                    - KK                       - Ijazah\n- KTM                   - Paspor                  - BPJS",
    ),
    TermsAndConditions(
      title: "Alamat",
      content:
          "Rumah Rental Camera (RRC)\nJl. Sumber Bening depan Puskesmas Kembiritan\nDemi keamanan barang kami tidak melakukan CO (Cash On Delivery)",
    ),
    TermsAndConditions(
      title: "Jam Operasional : 06.00 - 22.00",
      content: """
  -> Batas Keterlambatan Pengambilan: 1 jam
  -> Denda terlambat pengembalian 50K/3 jam
  -> Telat diatas 3 jam dihitung biaya sewa  1 hari
  -> Khusus untuk sewa unit dengan durasi 6 jam, 
  -> pengembalian harus tepat pada waktunya apabila terlambat dikenakan biaya sewa 12 jam
      """,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Add your back button functionality here
              Navigator.pop(context);
            },
          ),
          title: Text("Syarat dan Ketentuan"),
          backgroundColor: Color(0xff000000),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Color(0xfffdebeb), // Ganti warna latar belakang
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var term in termsAndConditions)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        term.title,
                        style: TextStyle(
                          fontSize: 24, // Ganti ukuran font
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bodoni MT Condensed', // Ganti jenis font
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        term.content,
                        style: TextStyle(
                          fontSize: 20, // Ganti ukuran font
                          fontFamily: 'Bodoni MT Condensed', // Ganti jenis font
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
