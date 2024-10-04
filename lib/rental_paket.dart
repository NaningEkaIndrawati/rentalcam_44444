import 'package:belajar/Api/kamera.dart';
import 'package:belajar/Api/paket.dart';
import 'package:belajar/form_paket.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/camera.dart';
import 'package:belajar/model/paket.dart';
import 'package:flutter/material.dart';
import 'form_camera.dart';

class PaketPage extends StatefulWidget {
  @override
  State<PaketPage> createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Paket> paket = [];
  List<Paket> filteredpaket = [];

  @override
  void initState() {
    super.initState();
    _fetchPaket();
  }

  Future<void> _fetchPaket() async {
    try {
      List<Paket> fetchedpaket = await PaketApi.getPaket();
      setState(() {
        paket = fetchedpaket;
        filteredpaket = fetchedpaket;
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
              onChanged: (value) {
                setState(() {
                  filteredpaket = paket
                      .where((paket) => paket.namaAlat
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
            itemCount: filteredpaket.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaketDetailsWidget(paket: filteredpaket[index]),
                    ),
                  );
                },
                child: PaketItem(paket: filteredpaket[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PaketItem extends StatelessWidget {
  final Paket paket;
  PaketItem({required this.paket});

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
              '${ApiUrl.localhost}images/' + paket!.gambar.toString(),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              paket.namaAlat.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text('6 Jam: ${paket.harga6}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 13, 47, 75))),
          ),
          Center(
            child: Text('12 Jam: ${paket.harga12}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 8, 63, 9))),
          ),
          Center(
            child: Text('24 Jam: ${paket.harga24}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 65, 43, 11))),
          ),
          SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaketDetailsWidget(paket: paket),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(0, 4, 0, 44),
            ),
            child: Text('Detail'),
          ),
        ],
      ),
    );
  }
}

class PaketDetailsWidget extends StatelessWidget {
  final Paket paket;

  PaketDetailsWidget({required this.paket});

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
        title: Text(paket.namaAlat ?? ''),
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
                '${ApiUrl.localhost}images/' + (paket.gambar?.toString() ?? ''),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text('Deskripsi babi : '),
            SizedBox(height: 16),
            Text(paket.deskripsi ?? 'Tidak Ada Deskripsi pepek'),
            SizedBox(height: 16),
            Text('Harga : '),
            SizedBox(height: 16),
            Text('6 Jam: ${paket.harga6}'),
            SizedBox(height: 8),
            Text('12 Jam: ${paket.harga12}'),
            SizedBox(height: 8),
            Text('24 Jam: ${paket.harga24}'),
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
                builder: (context) => FormPaket(paket: paket),
              ),
            );
          },
          label: Text('Sewa Langsung cuy'),
          icon: Icon(Icons.shopping_cart),
          backgroundColor: Color(0xff000000),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Color.fromARGB(255, 248, 232, 232),
    );
  }
}
