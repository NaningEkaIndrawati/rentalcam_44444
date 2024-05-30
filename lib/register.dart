import 'dart:convert';
import 'dart:io';
import 'package:belajar/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:belajar/AuthApi/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noTelephoneController = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    // print(imageFile);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/rrc.png', // Pastikan path asset yang benar
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              'Rumah Rental Camera',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xff000000),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 248, 232, 232),
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                obscureText: true,
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: noTelephoneController,
                decoration: InputDecoration(
                  labelText: 'No WhatsApp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[600],
                      ),
              ),
              SizedBox(height: 12.0),

              SizedBox(height: 12.0),

              // Tombol untuk memilih gambar dari galeri
              ElevatedButton(
                onPressed: () async {
                  final pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      imageFile = File(pickedFile.path);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], // Warna latar belakang tombol
                  onPrimary: Colors.black, // Warna teks tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child:
                    Text('Choose Image', style: TextStyle(color: Colors.black)),
              ),

              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String alamat = alamatController.text;
                  String noTelephone = noTelephoneController.text;

                  await AuthApi.register(
                    name: name,
                    email: email,
                    password: password,
                    alamat: alamat,
                    telepon: noTelephone,
                    imageFile: imageFile,
                    context: context,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  primary: Color(0xff330b0b),
                ),
                child: Text('Register'),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Sudah Punya Akun? Login Disini",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(
                          255, 13, 13, 13), // You can set your preferred color
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
