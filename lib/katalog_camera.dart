import 'package:belajar/Api/kamera.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/camera.dart';
import 'package:flutter/material.dart';
import 'form_penyewaan.dart';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Kamera> cameras = [];
  List<Kamera> filteredCameras = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<Kamera> fetchedCameras = await KameraApi.getCamera();
      setState(() {
        cameras = fetchedCameras;
        filteredCameras = fetchedCameras;
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(cameras);
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
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Canon 650D",
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          backgroundColor: Color(0xff000000),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xfff5dfdf),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: cameras.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CameraDetailsWidget(cameraDetails: cameras[index]),
                    ),
                  );
                },
                child: CameraItem(camera: cameras[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CameraItem extends StatelessWidget {
  final Kamera camera;
  CameraItem({required this.camera});

  @override
  Widget build(BuildContext context) {
    print('LINK:::  ${ApiUrl.localhost}images/' + camera!.gambar.toString());
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xff000000)),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${ApiUrl.localhost}images/' + camera!.gambar.toString(),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                camera.namaAlat,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                camera.harga6.toString(),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                camera.harga12.toString(),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                camera.harga24.toString(),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CameraDetailsWidget extends StatelessWidget {
  final Kamera cameraDetails;

  CameraDetailsWidget({required this.cameraDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(cameraDetails.namaAlat),
        backgroundColor: Color(0xff000000),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(
                '${ApiUrl.localhost}images/' + cameraDetails.gambar.toString(),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(cameraDetails.harga6),
            SizedBox(height: 16),
            Text(
              "Completeness:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(cameraDetails.harga24),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Navigasi ke halaman FormPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalForm(),
              ),
            );
          },
          label: Text('Sewa Langsung'),
          icon: Icon(Icons.shopping_cart),
          backgroundColor: Color(0xff000000),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Change to endFloat for bottom right corner
      backgroundColor: Color(0xfffff4f4), // Set your desired background color
    );
  }
}
