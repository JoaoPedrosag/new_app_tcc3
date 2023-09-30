import 'dart:ui';

import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

class ImageFilterCustom extends StatelessWidget {
  final RecordCubit cubit;
  const ImageFilterCustom({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: Text(
              cubit.text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
