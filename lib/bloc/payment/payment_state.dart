
part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();

  @override
  List<Object> get props => [];
}


class PaymentSuccess extends PaymentState {
  final String? message;

  const PaymentSuccess(this.message);

  @override
  List<Object> get props => [message!];
}



class PaymentFailed extends PaymentState {
  final String? message;

  const PaymentFailed(this.message);

  @override
  List<Object> get props => [message!];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();

  @override
  List<Object> get props => [];
}