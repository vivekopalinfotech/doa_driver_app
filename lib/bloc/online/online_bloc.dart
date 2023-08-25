import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/repos/online_repo.dart';
import 'package:doa_driver_app/repos/otp_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'online_event.dart';
part 'online_state.dart';

class OnlineBloc extends Bloc<OnlineEvent, OnlineState> {
  final OnlineRepo onlineRepo;

  OnlineBloc(this.onlineRepo) : super(const OnlineInitial());

  @override
  Stream<OnlineState> mapEventToState(OnlineEvent event) async* {
    if (event is PerformOnline) {
      try {
        final onlineResponse = await onlineRepo.online(event.id,event.status);
        if (onlineResponse.isNotEmpty) {
          yield OnlineSuccess(onlineResponse);
        } else {
          yield OnlineFailed(onlineResponse);
        }
      } on Error {
        yield const OnlineFailed("Some Error");
      }
    }
  }
}
