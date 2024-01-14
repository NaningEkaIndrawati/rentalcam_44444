import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/aksesoris.dart';
import 'package:flutter/material.dart';
import 'form_penyewaan.dart';
import 'Api/accessories.dart';

class AccesoriesPage extends StatefulWidget {
  @override
  _AccesoriesPageState createState() => _AccesoriesPageState();
}

class _AccesoriesPageState extends State<AccesoriesPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Aksesoris> accessories = [];
  List<Aksesoris> filteredAccessories = [];

  @override
  void initState() {
    super.initState();
    _fetchAccessories();
  }

  Future<void> _fetchAccessories() async {
    try {
      List<Aksesoris> fetchedAccessories =
          await AccessoriesApi.getAccessories();
      setState(() {
        accessories = fetchedAccessories;
        filteredAccessories = fetchedAccessories;
      });
    } catch (error) {
      print('Error fetching accessories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(accessories);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
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
                hintText: "Accessories",
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
            itemCount: accessories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccessoriesDetailWidget(
                        accessoriesDetails: accessories[index],
                      ),
                    ),
                  );
                },
                child: AccessoriesItem(
                  accessories: accessories[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AccessoriesItem extends StatelessWidget {
  final Aksesoris accessories;

  AccessoriesItem({required this.accessories});

  @override
  Widget build(BuildContext context) {
    print(accessories.namaAlat);
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
                '${ApiUrl.localhost}images/' + accessories.gambar.toString() ??
                    '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                accessories.namaAlat!,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                accessories.deskripsi ?? '',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                accessories.harga6.toString() ?? '',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                accessories.harga12.toString() ?? '',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                accessories.harga24.toString() ?? '',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccessoriesDetailWidget extends StatelessWidget {
  final Aksesoris accessoriesDetails;

  AccessoriesDetailWidget({required this.accessoriesDetails});

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
        title: Text(accessoriesDetails.namaAlat!),
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
                        accessoriesDetails.gambar.toString() ??
                    '',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(accessoriesDetails.deskripsi ?? ''),
            SizedBox(height: 16),
            Text(
              "Completeness:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "${accessoriesDetails.harga6} :",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "${accessoriesDetails.harga12} ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "${accessoriesDetails.harga24} ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Color(0xfffff4f4),
    );
  }
}
