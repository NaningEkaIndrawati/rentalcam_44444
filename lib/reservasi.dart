import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  final String pricePerHour;
  final String date;

  Second({
    required this.pricePerHour,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String formattedPrice = pricePerHour.replaceAll(RegExp(r'\.000$'), '');

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
      body: Container(
        color: Color.fromARGB(
            255, 255, 229, 229), // Set light pink background color
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
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
                  Text(
                    'Price per Hour',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Rp. $formattedPrice',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
