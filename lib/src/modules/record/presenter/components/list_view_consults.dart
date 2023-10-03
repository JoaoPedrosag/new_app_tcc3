import 'package:app_hospital/src/core/utils/functions.dart';
import 'package:app_hospital/src/modules/record/domain/entities/consults_request.dart';
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(consult.convertedText),
                subtitle: Text(Functions.formatDate(consult.createdAt)),
                trailing: const Icon(Icons.play_arrow),
              ),
            ),
          );
        },
      ),
    );
  }
}
