import 'package:app_hospital/src/modules/record/useCases/consults_request.dart';
import 'package:flutter/material.dart';

class ListViewConsults extends StatelessWidget {
  final List<ConsultsRequest> consults;
  const ListViewConsults({super.key, required this.consults});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: consults.length,
        itemBuilder: (context, index) {
          final consult = consults[index];
          return ListTile(
            title: Text(consult.id.toString()),
            subtitle: Text(consult.convertedText),
          );
        },
      ),
    );
  }
}
