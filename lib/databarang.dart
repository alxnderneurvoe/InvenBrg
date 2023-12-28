// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBarang extends StatelessWidget {
  final DocumentSnapshot barang;

  const DetailBarang({super.key, required this.barang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Detail Barang',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Kode Barang : ${barang['kode barang']}',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50.0),
            const Text(
              'Detail Barang',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            DataTable(
              dataRowMinHeight: 40.0,
              columnSpacing: 10.0,
              columns: const [
                DataColumn(
                  label: Text('........................................',
                      style: TextStyle(color: Color.fromARGB(0, 0, 0, 255))),
                ),
                DataColumn(label: Text('')),
                DataColumn(label: Text('')),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Nama Barang'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(Expanded(child: Text('${barang['nama barang']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Kategori Barang'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(
                      Expanded(child: Text('${barang['kategori barang']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Suplier'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(
                      Expanded(child: Text('${barang['suplier barang']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Jumlah Barang'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(Expanded(child: Text('${barang['jumlah barang']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Total Harga'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(Expanded(child: Text('${barang['total harga']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Jenis Pembayaran'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(
                      Expanded(child: Text('${barang['jenis pembayaran']}'))),
                ]),
                DataRow(cells: [
                  const DataCell(Expanded(child: Text('Update terakhir'))),
                  const DataCell(Expanded(child: Text(':'))),
                  DataCell(Expanded(
                    child: Text(
                      DateFormat('EEEE, dd - MM - yyyy')
                          .format(barang['tanggal input'].toDate()),
                    ),
                  )),
                ]),
                const DataRow(cells: [
                  DataCell(Expanded(child: Text(''))),
                  DataCell(Expanded(child: Text(''))),
                  DataCell(Expanded(child: Text(''))),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
