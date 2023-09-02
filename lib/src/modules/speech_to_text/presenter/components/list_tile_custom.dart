import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String namePatient;
  final int idPatient;
  final String date;
  const ListTileCustom(
      {super.key,
      required this.namePatient,
      required this.idPatient,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        title: Text('Paciente: $namePatient'),
        subtitle: Text('Data da internação: $date'),
        leading: ClipOval(
          child: Image.asset(
            'assets/img/user.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
