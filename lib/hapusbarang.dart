// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(
    BuildContext context, DocumentSnapshot barang) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Konfimasi Hapus"),
        content: const Text("Anda yakin akan menghapus item ini ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              deleteItem(barang);
              Navigator.pop(context);

              showDeleteSuccessNotification(context);
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}

void showDeleteSuccessNotification(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Delete success!"),
      duration: Duration(seconds: 3),
    ),
  );
}

void deleteItem(DocumentSnapshot barang) async {
  try {
    await barang.reference.delete();

    print("Data telah di hapus");
  } catch (e) {
    print("Error deleting booking: $e");
  }
}
