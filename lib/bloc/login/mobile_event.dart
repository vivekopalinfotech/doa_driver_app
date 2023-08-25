
part of 'mobile_bloc.dart';
abstract class MobileEvent extends Equatable {
  const MobileEvent();
}

class PerformMobile extends MobileEvent {
  final String mobile;

  const PerformMobile(this.mobile,);

  @override
  List<Object> get props => [mobile];
}


