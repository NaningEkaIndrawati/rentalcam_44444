import 'package:belajar/Api/reservasi.dart';
import 'package:belajar/model/paket.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FormPaket extends StatefulWidget {
  Paket paket;

  FormPaket({required this.paket});

  @override
  _FormPaketState createState() => _FormPaketState();
}

class _FormPaketState extends State<FormPaket> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  late Paket paket;
  DateTime? _pickupDate;
  int _selectedPricePerHour = 0;
  List<String> pricePerHourOptions = [];
  File? _imageFile;

  List<String> methodePembayaran = [
    'Transfer',
    'Cash',
  ];
  String? selectedMethodePembayaran; // Initialize with first element

  @override
  void initState() {
    super.initState();
    paket = widget.paket;
    buildPricePerHour();
  }

  void buildPricePerHour() {
    String harga6 = "6 Jam : ${paket.harga6}";
    String harga12 = "12 Jam : ${paket.harga12}";
    String harga24 = "24 Jam : ${paket.harga24}";

    _selectedPricePerHour = 6;

    pricePerHourOptions.add(harga6);
    pricePerHourOptions.add(harga12);
    pricePerHourOptions.add(harga24);
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Widget _buildDateTextField(
      String labelText, DateTime? selectedDate, Function(DateTime?) onChanged) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(selectedDate == null
            ? 'Select $labelText'
            : '$labelText: ${dateFormat.format(selectedDate)} ${selectedDate.toLocal().hour}:${selectedDate.toLocal().minute.toString().padLeft(2, '0')}'),
        trailing: Icon(Icons.calendar_today),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              DateTime selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );

              onChanged(selectedDateTime);

              _dateController.text = dateFormat.format(pickedDate);
              _timeController.text =
                  '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';
            }
          }
        },
      ),
    );
  }

  Widget _buildLabelLeftAligned(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPricePerHourDropdown() {
    List<int> pricePerHourValues = [6, 12, 24];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              'Durasi Sewa: ${pricePerHourOptions[pricePerHourValues.indexOf(_selectedPricePerHour)]}',
              style: TextStyle(fontSize: 16),
            ),
            trailing: DropdownButton<int>(
              value: _selectedPricePerHour,
              onChanged: (int? value) {
                setState(() {
                  _selectedPricePerHour = value!;
                });
              },
              items: List.generate(pricePerHourOptions.length, (index) {
                return DropdownMenuItem<int>(
                  value: pricePerHourValues[index],
                  child: Text(pricePerHourOptions[index]),
                );
              }),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(
              'Pilih Methode Pembayaran: ${selectedMethodePembayaran ?? 'Belum dipilih'}',
              style: TextStyle(fontSize: 16),
            ),
            trailing: DropdownButton<String>(
              value: selectedMethodePembayaran,
              onChanged: (String? value) {
                setState(() {
                  selectedMethodePembayaran = value!;
                });
              },
              items: methodePembayaran.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Container informasiPembayaran() {
    if (selectedMethodePembayaran == 'Transfer') {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
              onTap: _uploadImage,
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
            if (_imageFile != null) Image.file(_imageFile!),
          ],
        ),
      );
    } else {
      return Container(); // Return empty container if the payment method is not 'Transfer'
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Penyewaan',
          style: TextStyle(
            color: Color.fromARGB(255, 248, 232, 232),
          ),
        ),
        backgroundColor: Color(0xff080808),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Isi formulir penyewaan Camera ${paket.namaAlat}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            _buildLabelLeftAligned("Pilih Durasi Sewa"),
            _buildPricePerHourDropdown(),
            _buildLabelLeftAligned("Pilih Tanggal Pengambilan"),
            _buildDateTextField("pengambilan pada", _pickupDate, (pickedDate) {
              setState(() {
                _pickupDate = pickedDate;
              });
            }),
            informasiPembayaran(),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                backgroundColor: Color(
                  0xff161515,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              onPressed: () {
                String startDate = _dateController.text;
                String startTime = _timeController.text;
                int waktuSewa = _selectedPricePerHour;
                String idAlat = paket.id.toString();

                ReservasiApi.createReservasi(
                    idAlat: idAlat,
                    startDate: startDate,
                    startTime: startTime,
                    waktuSewa: waktuSewa.toString(),
                    context: context);
              },
              child: Text(
                'Sewa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
