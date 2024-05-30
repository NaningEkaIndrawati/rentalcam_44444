import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class FormPenyewaan extends StatefulWidget {
  const FormPenyewaan({super.key});

  @override
  State<FormPenyewaan> createState() => _FormPenyewaanState();
}

class _FormPenyewaanState extends State<FormPenyewaan> {
  TextEditingController durasiController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController jumlahPembayaranController = TextEditingController();
  TextEditingController methodePembayaranController = TextEditingController();
  List<String> durasiSewa = [
    '6 jam : 50.000',
    '12 jam : 100.000',
    '24 jam : 150.000',
  ];
  String? selectedDurasi; // Initialize with first element

  List<String> methodePembayaran = [
    'Transfer',
    'Cash',
  ];
  String? selectedMethodePembayaran; // Initialize with first element

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3D4D4),
      appBar: AppBar(
        title: Text(
          'Form Penyewaan',
          style: TextStyle(
            color: Color.fromARGB(255, 248, 232, 232),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff080808),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'isi formulir penyewaaan Camera Sony a5000',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Pilih Durasi Sewa',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownDurasiSewa(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Pilih Tanggal Pengembalian',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TanggalInput(),
              SizedBox(
                height: 16,
              ),
              JumlahPembayaran(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Pilih Methode Pembayaran',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownMethodePembayaran(),
              SizedBox(
                height: 16,
              ),
              informasiPembayaran(),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Color(0xff161515),
                  // foregroundColor: Colors.white,
                ),
                onPressed: () {
                  print(durasiController.text);
                  print(jumlahPembayaranController.text);
                  print(methodePembayaranController.text);
                },
                child: Text(
                  'Sewa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField JumlahPembayaran() {
    return TextField(
      controller: jumlahPembayaranController,
      style: TextStyle(
        color: Colors.green.shade400,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: "Jumlah Pembayaran",
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      readOnly: true,
    );
  }

  TextField TanggalInput() {
    return TextField(
      controller: tanggalController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: "Pilih Pengambilan Pada",
        filled: true,
        suffixIcon: Icon(Icons.calendar_month),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      onTap: () {
        _selectedDate();
      },
      readOnly: true,
    );
  }

  Future<void> _selectedDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (_picked != null) {
      setState(() {
        final formatter = DateFormat(
            'dd MMMM yyyy', Intl.defaultLocale); // Set locale to Indonesian
        tanggalController.text = formatter.format(_picked);
      });
    }
  }

  String? _getPriceFromDuration(String? duration) {
    if (duration == null) return null;
    final parts = duration.split(':');
    if (parts.length != 2) return null;
    final priceString = parts[1].trim();
    return priceString;
  }

  Container DropdownDurasiSewa() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        underline: Container(color: Colors.transparent),
        value: selectedDurasi,
        isExpanded: true,
        items: durasiSewa.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedDurasi = newValue!;
            durasiController.text = newValue;
            jumlahPembayaranController.text =
                'Jumlah Pembayaran ${_getPriceFromDuration(newValue)!}';
          });
        },
        hint: Text(
          'Pilih Pengambilan Pada',
        ), // Optional hint for initial state
      ),
    );
  }

  Container DropdownMethodePembayaran() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        underline: Container(color: Colors.transparent),
        value: selectedMethodePembayaran,
        isExpanded: true,
        items: methodePembayaran.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedMethodePembayaran = newValue!;
            methodePembayaranController.text = newValue;
          });
        },
        hint: Text(
          'Pilih Methode Pembayaran',
        ), // Optional hint for initial state
      ),
    );
  }

  Container informasiPembayaran() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xff9FC6DC),
            child: Text(
              'Informasi Pembayaran',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Silahkan melakukan pembayaran melalui rekening ini',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green.shade400,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            width: MediaQuery.of(context).size.width * 3 / 5,
            decoration: BoxDecoration(
                color: Color(0xff352C2C),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              'Bank BNI 0576854329087',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            width: MediaQuery.of(context).size.width * 3 / 5,
            decoration: BoxDecoration(
                color: Color(0xff352C2C),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              'Bank BRI 0576854329087',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              width: MediaQuery.of(context).size.width * 2 / 4,
              decoration: BoxDecoration(
                  color: Color(0xffF83333),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                'Upload Bukti Pembayaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
