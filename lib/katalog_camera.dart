import 'package:belajar/Api/kamera.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/camera.dart';
import 'package:flutter/material.dart';
import 'form_camera.dart';

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
    print(filteredCameras);
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
              onChanged: (value) {
                setState(() {
                  filteredCameras = cameras
                      .where((camera) => camera.namaAlat
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
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
            color: Color.fromARGB(255, 248, 232, 232),
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
            itemCount: filteredCameras.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraDetailsWidget(
                          cameraDetails: filteredCameras[index]),
                    ),
                  );
                },
                child: CameraItem(camera: filteredCameras[index]),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center content horizontally
        children: [
          Center(
            child: Image.network(
              '${ApiUrl.localhost}images/' + camera!.gambar.toString(),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              camera.namaAlat,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text('6 Jam: ${camera.harga6}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 13, 47, 75))),
          ),
          Center(
            child: Text('12 Jam: ${camera.harga12}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 8, 63, 9))),
          ),
          Center(
            child: Text('24 Jam: ${camera.harga24}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 65, 43, 11))),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CameraDetailsWidget(cameraDetails: camera),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  'Detail',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Tersedia 1',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
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
        title: Text(cameraDetails.namaAlat ?? ''),
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
                '${ApiUrl.localhost}images/' +
                    (cameraDetails.gambar?.toString() ?? ''),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text('Deskripsi : '),
            SizedBox(height: 16),
            Text(cameraDetails.deskripsi ?? 'Tidak Ada Deskripsi'),
            SizedBox(height: 16),
            Text('Harga : '),
            SizedBox(height: 16),
            Text('6 Jam: ${cameraDetails.harga6}'),
            SizedBox(height: 8),
            Text('12 Jam: ${cameraDetails.harga12}'),
            SizedBox(height: 8),
            Text('24 Jam: ${cameraDetails.harga24}'),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormCamera(kamera: cameraDetails),
              ),
            );
          },
          label: Text('Sewa Langsung'),
          icon: Icon(Icons.shopping_cart),
          backgroundColor: Color(0xff000000),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Color.fromARGB(255, 248, 232, 232),
    );
  }
}
