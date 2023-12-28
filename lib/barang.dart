// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'databarang.dart';
import 'hapusbarang.dart';

class DataBarang extends StatefulWidget {
  const DataBarang({super.key});

  @override
  _DataBarangState createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Barang').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot barang = snapshot.data!.docs[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: ListTile(
                          title: Row(
                            children: [
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    barang['nama barang'],
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 120,
                                          child: Text('Kode Barang')),
                                      Text(': ${barang['kode barang']}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width: 120,
                                          child: Text('Jumlah Barang')),
                                      Text(': ${barang['jumlah barang']}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 120,
                                        child: Text('Sisa Barang'),
                                      ),
                                      FutureBuilder<int>(
                                        future: getSisaBarang(
                                            barang['kode barang']),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text(': Loading...');
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            int sisaBarang = snapshot.data ?? 0;
                                            return Text(': $sisaBarang');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            navToDetailBarang(context, barang);
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDeleteConfirmationDialog(context, barang);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        'Data Barang kosong :(',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Silahkan tambah data anda',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        height: 300,
                        child: Lottie.asset(
                          'assets/LoadingBox.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<int> getSisaBarang(String kodeBarang) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Barang')
        .doc(kodeBarang)
        .collection('Atur Barang')
        .doc(kodeBarang)
        .get();

    if (documentSnapshot.exists) {
      return documentSnapshot['sisa barang'] as int;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

void navToDetailBarang(BuildContext context, DocumentSnapshot barang) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailBarang(barang: barang),
    ),
  );
}
