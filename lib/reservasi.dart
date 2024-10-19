import 'package:belajar/katalog_camera.dart';
import 'package:flutter/material.dart';
import 'package:belajar/Api/riwayat.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/riwayat.dart';

class Second extends StatefulWidget {
  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.warning), text: "Denda"),
            Tab(icon: Icon(Icons.shopping_cart), text: "Penyewaan"),
            Tab(icon: Icon(Icons.check_circle), text: "Selesai"),
          ],
        ),
      ),
      body: FutureBuilder<List<Riwayat>>(
        future: RiwayatApi.getRiwayat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Riwayat> riwayat = snapshot.data!;
            return TabBarView(
              controller: _tabController,
              children: [
                _buildDendaTab(),
                _buildPenyewaanTab(riwayat),
                _buildSelesaiTab(riwayat),
              ],
            );
          }
        },
      ),
    );
  }

  // Tab for displaying fines (denda)
  Widget _buildDendaTab() {
    return FutureBuilder<List<Riwayat>>(
      future: RiwayatApi.getRiwayat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Riwayat> riwayat = snapshot.data!;
          List<Riwayat> denda = riwayat.where((item) => _isOverdue(item)).toList();
          return _buildFineList(denda);
        }
      },
    );
  }

  // Check if the transaction is overdue
  bool _isOverdue(Riwayat riwayat) {
    DateTime endTime = DateTime.parse(riwayat.orderApi!.ends!); // End time of the rental
    DateTime currentTime = DateTime.now();
    return currentTime.isAfter(endTime); // Returns true if overdue
  }

  // Build the list of fines
  Widget _buildFineList(List<Riwayat> overdueTransactions) {
  if (overdueTransactions.isEmpty) {
    return Center(child: Text("No fines yet."));
  } else {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: overdueTransactions.length,
      itemBuilder: (context, index) {
        Riwayat riwayat = overdueTransactions[index];
        double fineAmount = _calculateFine(riwayat); // Calculate the fine amount
        return _buildFineCard(riwayat, fineAmount);
      },
    );
  }
}

Widget _buildFineCard(Riwayat riwayat, double fineAmount) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            '${ApiUrl.localhost}images/' + riwayat.orderApi!.alat!.gambar.toString(),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                riwayat.orderApi!.alat!.namaAlat ?? 'Unknown Equipment',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                riwayat.orderApi!.alat!.namaAlat ?? 'Equipment ID',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Denda',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          'Rp.${fineAmount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

  // Calculate the fine based on the overdue time
  double _calculateFine(Riwayat riwayat) {
    DateTime endTime = DateTime.parse(riwayat.orderApi!.ends!);
    DateTime currentTime = DateTime.now();
    Duration overdueDuration = currentTime.difference(endTime);
    
    // Example: Fine is Rp. 5000 per hour overdue
    double finePerHour = 5000.0;
    int overdueHours = overdueDuration.inHours;
    
    return overdueHours * finePerHour;
  }
}

  Widget _buildPenyewaanTab(List<Riwayat> riwayat) {
    List<Riwayat> penyewaan = riwayat.where((item) => item.status == 1).toList();
    return _buildTransactionList(penyewaan);
  }

  Widget _buildSelesaiTab(List<Riwayat> riwayat) {
    List<Riwayat> selesai = riwayat.where((item) => item.status != 1).toList();
    return _buildTransactionList(selesai, showRatingAndReview: true);
  }

 Widget _buildTransactionList(List<Riwayat> transactions, {bool showRatingAndReview = false}) {
  if (transactions.isEmpty) {
    return Center(child: Text("No transactions found."));
  } else {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index], context, showRatingAndReview);
      },
    );
  }
}

Widget _buildTransactionCard(Riwayat riwayat, BuildContext context, bool showRatingAndReview) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${ApiUrl.localhost}images/' + riwayat.orderApi!.alat!.gambar.toString(),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    riwayat.orderApi!.alat!.namaAlat ?? 'Unknown Equipment',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    riwayat.penyewa?.nama ?? 'Penyewa Unknown',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    riwayat.status == 1 ? 'Sedang Disewa' : 'Sudah Selesai',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: riwayat.status == 1 ? Colors.orange : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (riwayat.status == 1) // Show only for ongoing rentals
              ElevatedButton.icon(
                icon: Icon(Icons.access_time),
                label: Text('Perpanjang Sewa'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraDetailsWidget(
                        cameraDetails: riwayat.orderApi!.alat!,
                      ),
                    ),
                  );
                },
              ),
            SizedBox(width: 8.0),
            ElevatedButton.icon(
              icon: Icon(Icons.info),
              label: Text('Detail'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(riwayat: riwayat),
                  ),
                );
              },
            ),
            if (riwayat.status != 1) // Show only for completed rentals
              SizedBox(width: 8.0),
            if (riwayat.status != 1)
              ElevatedButton.icon(
                icon: Icon(Icons.shopping_cart),
                label: Text('Sewa Lagi'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraDetailsWidget(
                        cameraDetails: riwayat.orderApi!.alat!,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ],
    ),
  );
}

class DetailButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  DetailButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Riwayat riwayat;

  DetailPage({
    required this.riwayat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Detail'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${ApiUrl.localhost}images/' +
                        riwayat.orderApi!.alat!.gambar.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Color.fromARGB(255, 248, 232, 232),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailItem(
                      title: 'Price per Hour',
                      value:
                          '${riwayat.orderApi!.durasi.toString()} Jam :  Rp. ${riwayat.orderApi!.harga}'),
                  SizedBox(height: 16.0),
                  DetailItem(
                      title: 'Date',
                      value: riwayat.orderApi!.starts.toString()),
                  SizedBox(height: 16.0),
                  DetailItem(
                      title: 'Penyewa',
                      value: riwayat.penyewa!.nama.toString()),
                  SizedBox(height: 16.0),
                  DetailItem(
                      title: 'Telepon',
                      value: riwayat.penyewa!.telepon.toString()),
                  SizedBox(height: 16.0),
                  DetailItem(
                    title: 'Tanggal Pengambilan',
                    value: riwayat.orderApi!.ends.toString(),
                  ),
                  SizedBox(height: 16.0),
                  DetailItem(
                      title: 'Status',
                      value: riwayat.status.toString() == "1"
                          ? 'Sedang Disewa'
                          : "Sudah Selesai"),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  DetailItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
