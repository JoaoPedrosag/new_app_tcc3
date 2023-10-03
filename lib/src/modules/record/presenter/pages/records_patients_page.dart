import 'package:app_hospital/src/modules/record/presenter/components/list_view_consults.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/consult_cubit.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/consult_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecordsPatientPage extends StatefulWidget {
  const RecordsPatientPage({super.key});

  @override
  State<RecordsPatientPage> createState() => _RecordsPatientPageState();
}

class _RecordsPatientPageState extends State<RecordsPatientPage> {
  final consultCubit = Modular.get<ConsultCubit>();
  @override
  void initState() {
    consultCubit.getConsults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Registros do paciente'),
          ],
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ConsultCubit, ConsultState>(
              bloc: consultCubit,
              builder: (context, state) {
                return switch (state) {
                  ConsultInitial() => const Center(
                      child:
                          Text('Pressione o botão para carregar os registros'),
                    ),
                  ConsultLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ConsultSuccess(consults: final consults) =>
                    ListViewConsults(consults: consults),
                  ConsultFailure() => const Center(
                      child: Text('Erro ao carregar os registros'),
                    ),
                };
              }),
        ],
      ),
    );
  }
}
