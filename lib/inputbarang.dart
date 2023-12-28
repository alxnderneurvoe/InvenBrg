// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'handler/currency.dart';

class InputBarang extends StatefulWidget {
  const InputBarang({super.key});

  @override
  State<InputBarang> createState() => _InputBarangState();
}

class _InputBarangState extends State<InputBarang> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _kodeBrg = TextEditingController();
  final TextEditingController _namaBrg = TextEditingController();
  final TextEditingController _suplier = TextEditingController();
  final TextEditingController _jumlahBrg = TextEditingController();
  final TextEditingController _totalHarga = TextEditingController();
  bool isSendData = false;
  Uint8List? _selectedImage;

  String? _isiKategori;
  String? _jenisPembayaran;
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
              'FORM INPUT BARANG',
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
                child: TextFormField(
                  controller: _namaBrg,
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
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Kategori Barang',
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
                child: DropdownButtonFormField(
                  value: _isiKategori,
                  items: [
                    'Makanan',
                    'Minuman',
                    'Kebutuhan',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _isiKategori = value ?? "";
                    });
                  },
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                    hintText: 'pilih',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Suplier',
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
                  controller: _suplier,
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
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Jumlah Barang',
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
                      controller: _jumlahBrg,
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
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Total Harga',
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
                  controller: _totalHarga,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixText: 'Rp. ',
                    prefixStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Jenis Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 325,
                height: 60,
                child: DropdownButtonFormField(
                  value: _jenisPembayaran,
                  items: [
                    'Cash',
                    'Piutang',
                    'Digital',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _jenisPembayaran = value ?? "";
                    });
                  },
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                    hintText: 'pilih',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  'Gambar Barang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: _selectedImage != null
                        ? const Text(
                            'Gambar Terinput',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const Text(
                            "Upload Gambar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
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
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a photo'),
            duration: Duration(seconds: 4),
          ),
        );
        return;
      }
      String namaBrgtrim = _namaBrg.text;
      String imagePath = 'barang/$namaBrgtrim.jpg';
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(imagePath)
          .putData(_selectedImage!, metadata);

      await uploadTask.whenComplete(() async {
        String imageUrl =
            await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

        int jumlahBarang = int.tryParse(_jumlahBrg.text) ?? 0;

        await _firestore.collection('Barang').doc(_kodeBrg.text).set({
          'kode barang': _kodeBrg.text,
          'nama barang': _namaBrg.text,
          'kategori barang': _isiKategori,
          'suplier barang': _suplier.text,
          'jumlah barang': jumlahBarang,
          'total harga': _totalHarga.text,
          'jenis pembayaran': _jenisPembayaran,
          'gambar barang': imageUrl,
          'tanggal input': DateTime.now(),
        });
        await _firestore
            .collection('Barang')
            .doc(_kodeBrg.text)
            .collection('Atur Barang')
            .doc(_kodeBrg.text)
            .set({
          'kode barang': _kodeBrg.text,
          'sisa barang': jumlahBarang,
        });
        _kodeBrg.clear();
        _namaBrg.clear();
        _suplier.clear();
        _jumlahBrg.clear();
        _totalHarga.clear();
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

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _selectedImage = result.files.first.bytes;
      });
    }
  }

  void adjustValue(int increment) {
    int currentValue = int.tryParse(_jumlahBrg.text) ?? 0;
    int newValue = currentValue + increment;
    _jumlahBrg.text = newValue.toString();
  }
}
