import 'package:app_hospital/src/modules/records/presenter/components/list_view_consults.dart';
import 'package:app_hospital/src/modules/records/presenter/cubits/consults/consult_cubit.dart';
import 'package:app_hospital/src/modules/records/presenter/cubits/consults/consult_state.dart';
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
      body: RefreshIndicator(
        onRefresh: () async {
          consultCubit.getConsults();
        },
        child: Column(
          children: [
            BlocBuilder<ConsultCubit, ConsultState>(
                bloc: consultCubit,
                builder: (context, state) {
                  return switch (state) {
                    ConsultInitial() => Center(
                        child: Container(),
                      ),
                    ConsultLoading() => const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
