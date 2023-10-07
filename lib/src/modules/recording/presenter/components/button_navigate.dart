import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ButtonNavigate extends StatelessWidget {
  const ButtonNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Modular.to.pushNamed('/records/');
      },
      child: const Text('Acessar ultimos registros'),
    );
  }
}
