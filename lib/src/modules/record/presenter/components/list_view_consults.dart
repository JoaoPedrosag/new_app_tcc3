import 'package:app_hospital/src/core/utils/functions.dart';
import 'package:app_hospital/src/modules/record/domain/entities/consults_request.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/player/player_cubit.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/player/player_state_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListViewConsults extends StatelessWidget {
  final List<ConsultsRequest> consults;

  const ListViewConsults({super.key, required this.consults});

  @override
  Widget build(BuildContext context) {
    int? currentIndex;
    final cubit = Modular.get<PlayerCubit>();
    return BlocBuilder<PlayerCubit, PlayerStateAudio>(
      bloc: cubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: consults.length,
            itemBuilder: (context, index) {
              final consult = consults[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    currentIndex = index;
                    cubit.playAudio(id: consult.id.toString());
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(consult.convertedText),
                      subtitle: Text(Functions.formatDate(consult.createdAt)),
                      trailing: (currentIndex == index &&
                              !(state is PlayerStopped ||
                                  state is PlayerInitial ||
                                  state is PlayerCompleted))
                          ? const Icon(Icons.stop)
                          : const Icon(Icons.play_arrow),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
