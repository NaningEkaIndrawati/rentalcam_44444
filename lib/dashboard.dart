import 'package:belajar/reservasi.dart';
import 'package:flutter/material.dart';
import 'katalog_camera.dart';
import 'katalog_lensa.dart';
import 'katalog_accesories.dart';
import 'persyaratan.dart';
import 'rental_paket.dart';
import 'login.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 232, 232),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotifikasiPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Image.asset(
                        'images/rrc.png',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Kategori Pilihan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCategory(
                            context: context,
                            title: 'Camera',
                            imageUrl:
                                'https://id.canon/media/migration/shared/live/products/EN/eos6d-mkii-ef-24-105mm-l.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraPage()),
                              );
                            },
                          ),
                          buildCategory(
                            context: context,
                            title: 'Lensa',
                            imageUrl:
                                'https://media.foto-erhardt.de/images/product_images/popup_images/panasonic-lumix-s-pro-50mm-f14-159679214905510304.jpg',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LensaPage()),
                              );
                            },
                          ),
                          buildCategory(
                            context: context,
                            title: 'Accessories',
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1wY72GX70AUECJDwPb5q4MGgnm3XAdH7Xlw&usqp=CAU',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccesoriesPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCategory(
                            context: context,
                            title: 'Rental Paket',
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdtxMgRJ4Sy9Hyp1OaXwfa6q4sjzOzKij4jPBo5p5RgOYwyGoGTMYG7iEO0IRErF6r4mM&usqp=CAU',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaketPage()),
                              );
                            },
                          ),
                          buildCategory(
                            context: context,
                            title: 'Persyaratan',
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTy_7vR4kxr2USt2tH-ylop8RMOrQwvniKmjw&usqp=CAU',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersyaratanPage()),
                              );
                            },
                          ),
                          buildCategory(
                            context: context,
                            title: 'Riwayat',
                            imageUrl:
                                'https://w7.pngwing.com/pngs/789/908/png-transparent-curriculum-vitae-education-information-technology-research-technology-electronics-resume-logo-thumbnail.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Second()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xff000000),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/wa.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "08171009199",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                  Text(
                                    "08173232321",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/yt.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "RRC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/ig.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "@rumah_rental_camera_rrc",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/gmail.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "rumahrentalcamera4444@gmail.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/fb.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Rental Cam Genteng",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/location.png',
                              height: 18,
                              width: 18,
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jl. Sumber Bening depan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  "Genteng Puskesmas Kembiritan",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategory({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 50,
              width: 50,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 248, 232, 232)),
              child: Text(
                title,
                style: TextStyle(color: Color(0xff0f0f0f)),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class NotifikasiPage extends StatefulWidget {
  @override
  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        backgroundColor: Color.fromARGB(255, 16, 4, 3), // Warna AppBar
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          _buildNotificationCard(
            icon: Icons.warning_amber_rounded,
            title: 'Keterlambatan',
            content: 'Anda memiliki keterlambatan pengembalian alat.',
          ),
          _buildNotificationCard(
            icon: Icons.check_circle_outline,
            title: 'Pengembalian Berhasil',
            content: 'Anda telah mengembalikan alat dengan sukses.',
          ),
          _buildNotificationCard(
            icon: Icons.warning_amber_rounded,
            title: 'Keterlambatan',
            content: 'Anda memiliki keterlambatan pengembalian alat.',
          ),
          _buildNotificationCard(
            icon: Icons.check_circle_outline,
            title: 'Pengembalian Berhasil',
            content: 'Anda telah mengembalikan alat dengan sukses.',
          ),
          // Add more notifications as needed
        ],
      ),
    );
  }

  // Widget to build individual notification cards
  Widget _buildNotificationCard(
      {required IconData icon, required String title, required String content}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.red), // Custom icon and color
        title: Text(title),
        subtitle: Text(content),
        trailing: Icon(Icons.arrow_forward_ios), // Optional trailing icon
        onTap: () {
          // Add action when the notification is tapped if needed
        },
      ),
    );
  }
}
