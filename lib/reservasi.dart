import 'package:flutter/material.dart';
import 'package:belajar/Api/riwayat.dart';
import 'package:belajar/helpers/api_url.dart';
import 'package:belajar/model/riwayat.dart';

class Second extends StatefulWidget {
  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
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
      ),
      body: FutureBuilder(
        future: RiwayatApi.getRiwayat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Riwayat> riwayat = snapshot.data!;

            return ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount: riwayat.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Tampilkan judul hanya di atas kotak pertama
                  if (riwayat[index].status.toString() == "1") {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaksi Sedang Disewa:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        buildTransactionWidget(riwayat[index]),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaksi Sudah Dikembalikan:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        buildTransactionWidget(riwayat[index]),
                      ],
                    );
                  }
                } else {
                  // Jika bukan kotak pertama, tidak perlu menampilkan judul lagi
                  return buildTransactionWidget(riwayat[index]);
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget buildTransactionWidget(Riwayat riwayat) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              riwayat: riwayat,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama alat',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0), // Spacer
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              '${riwayat.orderApi!.alat!.namaAlat ?? ""}',
              style: TextStyle(
                fontSize: 19,
                color: Color.fromARGB(255, 12, 73, 106),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nama Penyewa',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              '${riwayat.penyewa!.nama ?? ""}',
              style: TextStyle(
                fontSize: 19,
                color: Color.fromARGB(255, 12, 73, 106),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              "${riwayat.orderApi!.starts ?? ""}",
              style: TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 53, 101, 140),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                if (riwayat.status.toString() == "1") ...[
                  Spacer(),
                  DetailButton(
                    title: 'Perpanjang Sewa',
                    onPressed: () {
                      // Implement perpanjangan sewa
                    },
                  ),
                ],
                Spacer(),
                if (riwayat.status.toString() != "1") ...[
                  DetailButton(
                    title: 'Sewa Lagi',
                    onPressed: () {
                      // Implement sewa lagi
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
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
            fontSize: 15.0,
            color: Color.fromARGB(255, 12, 73, 106),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
