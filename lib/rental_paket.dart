import 'package:flutter/material.dart';
import 'form_penyewaan.dart';

class RentalPackageDetails {
  String name;
  String rentalDetails;
  List<String> completeness;
  String imageUrl;

  RentalPackageDetails({
    required this.name,
    required this.rentalDetails,
    required this.completeness,
    required this.imageUrl,
  });
}

class PackagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RentalPackageDetails rentalPackage = RentalPackageDetails(
      name: "Rental Package",
      rentalDetails: "6 Jam : 200K\n12 Jam : 250K\n24 Jam : 300K",
      completeness: [
        "Stabilizer Moza Air Cros 2 Pro",
        "Lensa Fix 35 MM F1.8 OSS",
        "SDHC Sandisk 128GB Extrime Pro",
        "Mirrorless Sony A6400",
        "Lensa KIT 16-50 MM OSS",
        "Baterai Tambahan Total 2 Unit + Charger",
      ],
      imageUrl:
          "https://rentalalat.com/wp-content/uploads/2023/01/1.-Photographer-Fee.png",
    );

    return RentalPackageDetailsWidget(
      rentalPackageDetails: rentalPackage,
    );
  }
}

class RentalPackageDetailsWidget extends StatelessWidget {
  final RentalPackageDetails rentalPackageDetails;

  RentalPackageDetailsWidget({required this.rentalPackageDetails});

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
        title: Text(rentalPackageDetails.name),
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
                rentalPackageDetails.imageUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(rentalPackageDetails.rentalDetails),
            SizedBox(height: 16),
            Text(
              "Kelengkapan:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rentalPackageDetails.completeness
                  .map((item) => Text("• $item"))
                  .toList(),
            ),
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
