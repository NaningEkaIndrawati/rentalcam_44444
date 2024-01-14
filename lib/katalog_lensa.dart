import 'package:belajar/Api/lensa.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/lensa.dart';
import 'package:flutter/material.dart';
import 'form_penyewaan.dart';

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
            itemCount: lensas.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LensaDetailsWidget(lensaDetails: lensas[index]),
                    ),
                  );
                },
                child: LensaItem(lensa: lensas[index]),
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
                '${ApiUrl.localhost}images/' + lensa.gambar.toString(),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                lensa.namaAlat ?? "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                lensa.harga6?.toString() ?? "",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                lensa.harga12?.toString() ?? "",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                lensa.harga24?.toString() ?? "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
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
            Text(lensaDetails.harga6?.toString() ?? ""),
            SizedBox(height: 16),
            Text(
              "Completeness:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(lensaDetails.harga24?.toString() ?? ""),
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
