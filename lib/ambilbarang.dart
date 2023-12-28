// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AmbilBarang extends StatefulWidget {
  const AmbilBarang({super.key});

  @override
  State<AmbilBarang> createState() => _AmbilBarangState();
}

class _AmbilBarangState extends State<AmbilBarang> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _kodeBrg = TextEditingController();
  final TextEditingController _namaPtgs = TextEditingController();
  final TextEditingController _brgOut = TextEditingController();
  String _selectedNama = '';

  bool isSendData = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(
              'FORM PENGAMBILAN BARANG',
              style: GoogleFonts.abrilFatface(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // KODE BARANG KODE BARANG KODE BARANG KODE BARANG KODE BARANG KODE BARANG
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text(
                  'Kode Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 298,
                height: 50,
                child: TextFormField(
                  controller: _kodeBrg,
                  onChanged: (value) {
                    searchBrg(value);
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    counterText: '',
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text(
                  'Nama Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 298,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  width: 325,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '   $_selectedNama',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // JUMLAH BARANG KELUAR JUMLAH BARANG KELUAR JUMLAH BARANG KELUAR JUMLAH BARANG KELUAR JUMLAH BARANG KELUAR
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text(
                  'Jumlah Barang Keluar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _brgOut,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_upward),
                            onPressed: () {
                              adjustValue(1);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_downward),
                            onPressed: () {
                              adjustValue(-1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text(
                  'Tgl Ambil Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 298,
                height: 50,
                child: InkWell(
                  onTap: () => _selectDateAndTime(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          DateFormat('dd - MM - yyyy || HH:mm')
                              .format(selectedDate),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // NAMA PETUGAS NAMA PETUGAS NAMA PETUGAS NAMA PETUGAS NAMA PETUGAS
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text(
                  'Nama Petugas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 298,
                height: 50,
                child: TextFormField(
                  controller: _namaPtgs,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _saveDataToFirestore();
                  },
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isSendData
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Simpan",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveDataToFirestore() async {
    try {
      int jumlahBarangKeluar = int.tryParse(_brgOut.text) ?? 0;
      await _firestore
          .collection('Barang')
          .doc(_kodeBrg.text)
          .collection('Barang Keluar')
          .doc(_kodeBrg.text)
          .set({
        'kode barang': _kodeBrg.text,
        'nama barang': _selectedNama,
        'jumlah barang keluar': jumlahBarangKeluar,
        'tgl ambil barang': selectedDate,
        'nama petugas': _namaPtgs.text,
      });

      int sisaBarang = await getAvailableQuantityFromFirestore();
      int updatedSisaBarang = sisaBarang - jumlahBarangKeluar;
      await _firestore
          .collection('Barang')
          .doc(_kodeBrg.text)
          .collection('Atur Barang')
          .doc(_kodeBrg.text)
          .update({
        'sisa barang': updatedSisaBarang,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data terinput'),
          duration: Duration(seconds: 4),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> getAvailableQuantityFromFirestore() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('Barang')
          .doc(_kodeBrg.text)
          .collection('Atur Barang')
          .doc(_kodeBrg.text)
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot['sisa barang'] as int;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: today,
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
        initialEntryMode: TimePickerEntryMode.input,
      );
      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
        });
      }

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDate = combinedDateTime;
        });
      }
    }
  }

  void navBut(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AmbilBarang()),
    );
  }

  void searchBrg(String query) {
    FirebaseFirestore.instance
        .collection('Barang')
        .where('kode barang', isEqualTo: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String nama = querySnapshot.docs.first['nama barang'];
        setState(() {
          _selectedNama = nama;
        });
      } else {
        setState(() {
          _selectedNama = '';
        });
      }
    });
  }

  void adjustValue(int increment) {
    int currentValue = int.tryParse(_brgOut.text) ?? 0;
    int newValue = currentValue + increment;
    _brgOut.text = newValue.toString();
  }
}
