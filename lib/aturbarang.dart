// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AturBarang extends StatefulWidget {
  const AturBarang({super.key});

  @override
  State<AturBarang> createState() => _AturBarangState();
}

class _AturBarangState extends State<AturBarang> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _kodeBrg = TextEditingController();
  final TextEditingController _kodeRak = TextEditingController();
  String _selectedNama = '';
  int _selectedSisa = 0;
  int _selectedTotal = 0;

  bool isSendData = false;

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
              'FORM PENGATURAN BARANG',
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
                width: 130,
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
                width: 325,
                height: 50,
                child: TextFormField(
                  controller: _kodeBrg,
                  onChanged: (value) {
                    searchBrg(value);
                    searchSisa(value);
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
              ),
            ],
          ),
          const SizedBox(height: 15),
          // NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG NAMA BARANG
          Row(
            children: [
              const SizedBox(
                width: 130,
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
                width: 325,
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
          // KODE RAK KODE RAK KODE RAK KODE RAK KODE RAK KODE RAK KODE RAK KODE RAK KODE RAK
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Kode Rak',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 325,
                height: 50,
                child: TextFormField(
                  controller: _kodeRak,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG TOTAL BARANG
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Total Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 325,
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
                        '   $_selectedTotal',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // SISA BARANG SISA BARANG SISA BARANG SISA BARANG SISA BARANG SISA BARANG SISA BARANG
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Sisa Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 325,
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
                        '   $_selectedSisa',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
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
      await _firestore
          .collection('Barang')
          .doc(_kodeBrg.text)
          .collection('Atur Barang')
          .doc(_kodeBrg.text)
          .set({
        'kode barang': _kodeBrg.text,
        'nama barang': _selectedNama,
        'kode rak': _kodeRak.text,
        'total barang': _selectedTotal,
        'sisa barang': _selectedSisa,
        'tanggal input': DateTime.now(),
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

  void searchBrg(String query) {
    FirebaseFirestore.instance
        .collection('Barang')
        .where('kode barang', isEqualTo: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String nama = querySnapshot.docs.first['nama barang'];
        int total = querySnapshot.docs.first['jumlah barang'];
        setState(() {
          _selectedNama = nama;
          _selectedTotal = total;
        });
      } else {
        setState(() {
          _selectedNama = '';
          _selectedTotal = 0;
        });
      }
    });
  }

  void searchSisa(String query) {
    FirebaseFirestore.instance
        .collection('Barang')
        .doc(_kodeBrg.text)
        .collection('Atur Barang')
        .where('kode barang', isEqualTo: query)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        int sisa = querySnapshot.docs.first['sisa barang'];
        setState(() {
          _selectedSisa = sisa;
        });
      } else {
        setState(() {
          _selectedSisa = 0;
        });
      }
    });
  }
}
