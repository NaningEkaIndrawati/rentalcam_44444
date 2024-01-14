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
        backgroundColor: Color(
            0xfff8e5e5), // Add this line to set background color to transparent
        body: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  // Add your logout functionality here
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
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
                        'images/rrc.png', // Provide the correct asset path and wrap it with single quotes
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
                              // Navigate to CameraPage when the category is pressed
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
                                    builder: (context) => PackagePage()),
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
                              // Add your onTap functionality for the Riwayat category
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
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/wa.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '+62 813-3605-9335',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '+62 882-2821-9149',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'rumahrentalcamera4444@gmail.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset(
                            'images/location.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Jl. Sumber Bening depan Genteng Puskesmas Kembiritan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/yt.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RRC POTRET',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset(
                            'images/ig.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '@rumah_rental_camera_rrc',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Image.asset(
                            'images/fb.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'rumah rental camera',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
              style: ElevatedButton.styleFrom(primary: Color(0xfffde7e7)),
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
