import 'package:belajar/model/aksesoris.dart';
import 'package:flutter/material.dart';
import 'reservasi.dart';

class PersonalForm extends StatefulWidget {
   Aksesoris accessoriesDetails  = Aksesoris();

  PersonalForm({required this.accessoriesDetails});

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {

  final _quantityController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _pickupDate;
  DateTime? _returnDate;
  String _selectedPricePerHour = '6 Jam : 150K';
  List<String> pricePerHourOptions = [
    // '6 Jam : ${widget.accessoriesDetails.harga6.toString()}',
    // '12 Jam : ${widget.accessoriesDetails.harga12.toString()}',
    // '24 Jam : ${widget.accessoriesDetails.harga24.toString()}',
  ];

  Duration _getDurationFromPricePerHour(String pricePerHour) {
    switch (pricePerHour) {
      case '6 Jam : 150K':
        return Duration(hours: 6);
      case '12 Jam : 180K':
        return Duration(hours: 12);
      case '24 Jam : 200K':
        return Duration(hours: 24);
      default:
        return Duration(hours: 6);
    }
  }

  void _showSubmittedData() {
    final quantity = _quantityController.text;
    final date = _dateController.text;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submitted Data'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price per Hour: $_selectedPricePerHour'),
              Text('Quantity: $quantity'),
              Text('Date: $date'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Second(
                      pricePerHour: _selectedPricePerHour,
                      date: date,
                    ),
                  ),
                );
              },
              child: Text('View Details'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDateTextField(String labelText, DateTime? selectedDate,
      Function(DateTime?) onChanged, String pricePerHour) {
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
            : '$labelText: ${selectedDate.toLocal().toString().split(' ')[0]} ${selectedDate.toLocal().hour}:${selectedDate.toLocal().minute.toString().padLeft(2, '0')}'),
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

              // Update _dateController value when a date is picked
              _dateController.text = selectedDateTime.toLocal().toString();

              // Update _returnDate when pickup date is changed
              setState(() {
                _pickupDate = selectedDateTime;
                _returnDate = _pickupDate!
                    .add(_getDurationFromPricePerHour(pricePerHour));
              });
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
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text('$_selectedPricePerHour', style: TextStyle(fontSize: 16)),
        trailing: DropdownButton<String>(
          value: _selectedPricePerHour,
          onChanged: (String? value) {
            setState(() {
              _selectedPricePerHour = value!;
              if (_pickupDate != null) {
                _returnDate =
                    _pickupDate!.add(_getDurationFromPricePerHour(value));
              }
            });
          },
          items: _pricePerHourOptions
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form penyewaan',
          style: TextStyle(
            color: Colors.white,
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
          children: [
            _buildLabelLeftAligned("Price per Hour"),
            _buildPricePerHourDropdown(),
            _buildLabelLeftAligned("Tanggal Pengambilan"),
            _buildDateTextField("", _pickupDate, (pickedDate) {
              setState(() {
                _pickupDate = pickedDate;
                if (_pickupDate != null) {
                  _returnDate = _pickupDate!
                      .add(_getDurationFromPricePerHour(_selectedPricePerHour));
                }
              });
            }, _selectedPricePerHour),
            _buildLabelLeftAligned("Tanggal Pengembalian"),
            _buildDateTextField("", _returnDate, (pickedDate) {
              setState(() {
                _returnDate = pickedDate;
              });
            }, _selectedPricePerHour),
            ElevatedButton.icon(
              onPressed: () {
                _showSubmittedData();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff430f0c),
              ),
              icon: Icon(Icons.shopping_cart),
              label: Text('Sewa'),
            ),
          ],
        ),
      ),
    );
  }
}
