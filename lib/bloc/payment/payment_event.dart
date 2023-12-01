
part of 'payment_bloc.dart';
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class CheckPayment extends PaymentEvent {
  final String id;
  final String status;
  final double paid_cash;
  final double paid_cc_terminal;

  const CheckPayment(this.id,this.status, this.paid_cash, this.paid_cc_terminal);

  @override
  List<Object> get props => [id,status];
}


