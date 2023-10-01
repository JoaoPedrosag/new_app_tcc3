import 'package:flutter/material.dart';

class RecordsPatientPage extends StatelessWidget {
  const RecordsPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Row(
        children: [
          Text('Registros do paciente'),
        ],
      ),
    ));
  }
}
