import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddSaving extends StatefulWidget {
  const AddSaving({super.key});

  @override
  State<AddSaving> createState() => _AddSavingState();
}

class _AddSavingState extends State<AddSaving> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  bool isLoading = false;

  void saveSaving() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User belum login');

      await FirebaseFirestore.instance.collection('savings').add({
        'userId': user.uid,
        'name': nameController.text.trim(),
        'amount': int.parse(amountController.text.trim()),
        'duration': int.parse(durationController.text.trim()),
        'createdAt': Timestamp.now(),
        'progress': [],
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Tambah Tabungan')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nama Tabungan'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Masukkan nama tabungan' : null,
                ),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Jumlah yang ingin ditabung',
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Masukkan jumlah tabungan' : null,
                ),
                TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Waktu menabung (bulan)',
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Masukkan waktu menabung' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : saveSaving,
                  child:
                      isLoading
                          ? CircularProgressIndicator()
                          : Text('Simpan Tabungan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
