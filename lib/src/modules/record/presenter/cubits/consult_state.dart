import 'package:app_hospital/src/modules/record/useCases/consults_request.dart';

sealed class ConsultState {}

final class ConsultInitial extends ConsultState {}

final class ConsultLoading extends ConsultState {}

final class ConsultSuccess extends ConsultState {
  final List<ConsultsRequest> consults;
  ConsultSuccess({
    required this.consults,
  });
}

final class ConsultFailure extends ConsultState {
  final String message;
  ConsultFailure({
    required this.message,
  });
}
