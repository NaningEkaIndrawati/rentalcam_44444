import 'package:belajar/Api/lensa.dart';
import 'package:belajar/form_lensa.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/lensa.dart';
import 'package:flutter/material.dart';
import 'form_camera.dart';

class LensaPage extends StatefulWidget {
  @override
  State<LensaPage> createState() => _LensaPageState();
}

class _LensaPageState extends State<LensaPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Data> lensas = [];
  List<Data> filteredLensas = [];

  @override
  void initState() {
    super.initState();
    _fetchLensas();
  }

  Future<void> _fetchLensas() async {
    try {
      Lensa lensa = await LensaApi.getLensa();
      setState(() {
        lensas = lensa.data ?? [];
        filteredLensas = lensa.data ?? [];
      });
    } catch (error) {
      print('Error fetching lensas: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  filteredLensas = lensas
                      .where((lensa) => lensa.namaAlat
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
            itemCount: filteredLensas.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LensaDetailsWidget(
                          lensaDetails: filteredLensas[index]),
                    ),
                  );
                },
                child: LensaItem(lensa: filteredLensas[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LensaItem extends StatelessWidget {
  final Data lensa;
  LensaItem({required this.lensa});

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
              '${ApiUrl.localhost}images/' + lensa.gambar.toString(),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              lensa.namaAlat ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          Center(
            child: Text('6 Jam: ${lensa.harga6?.toString() ?? ""}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 13, 47, 75))),
          ),
          Center(
            child: Text('12 Jam: ${lensa.harga12?.toString() ?? ""}',
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 8, 63, 9))),
          ),
          Center(
            child: Text('24 Jam: ${lensa.harga24?.toString() ?? ""}',
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
                          LensaDetailsWidget(lensaDetails: lensa),
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

class LensaDetailsWidget extends StatelessWidget {
  final Data lensaDetails;

  LensaDetailsWidget({required this.lensaDetails});

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
        title: Text(lensaDetails.namaAlat ?? ""),
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
                '${ApiUrl.localhost}images/' + lensaDetails.gambar.toString(),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text('6 Jam: ${lensaDetails.harga6?.toString() ?? ""}'),
            SizedBox(height: 8),
            Text('12 Jam: ${lensaDetails.harga12?.toString() ?? ""}'),
            SizedBox(height: 8),
            Text('24 Jam: ${lensaDetails.harga24?.toString() ?? ""}'),
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
                builder: (context) => FormLensa(lensa: lensaDetails),
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
