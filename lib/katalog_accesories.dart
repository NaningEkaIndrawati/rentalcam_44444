import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/aksesoris.dart';
import 'package:flutter/material.dart';
import 'form_accessories.dart';
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
              onChanged: (value) {
                setState(() {
                  filteredAccessories = accessories
                      .where((acc) => acc.namaAlat
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
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
            color: Color.fromARGB(255, 246, 238, 238),
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
            itemCount: filteredAccessories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccessoriesDetailWidget(
                        accessoriesDetails: filteredAccessories[index],
                      ),
                    ),
                  );
                },
                child: AccessoriesItem(
                  accessories: filteredAccessories[index],
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              '${ApiUrl.localhost}images/' +
                  (accessories.gambar?.toString() ?? ''),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              accessories.namaAlat ?? '',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text('6 Jam: ${accessories.harga6}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 13, 47, 75))),
          ),
          Center(
            child: Text('12 Jam: ${accessories.harga12}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 8, 63, 9))),
          ),
          Center(
            child: Text('24 Jam: ${accessories.harga24}',
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
                      builder: (context) => AccessoriesDetailWidget(
                          accessoriesDetails: accessories),
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
        title: Text(accessoriesDetails.namaAlat ?? ''),
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
                    (accessoriesDetails.gambar?.toString() ?? ''),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text('6 Jam: ${accessoriesDetails.harga6}'),
            SizedBox(height: 8),
            Text('12 Jam: ${accessoriesDetails.harga12}'),
            SizedBox(height: 8),
            Text('24 Jam: ${accessoriesDetails.harga24}'),
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
                builder: (context) =>
                    FormAksesoris(aksesoris: accessoriesDetails),
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
