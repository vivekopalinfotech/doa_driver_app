// import 'package:doa_driver_app/constants/app_constants.dart';
// import 'package:doa_driver_app/models/order.dart';
// import 'package:doa_driver_app/repos/order_repo.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// part 'orders_event.dart';
//
// part 'orders_state.dart';
//
// class ProfileBloc extends Bloc<OrdersEvent, OrdersState> {
//   final OrderRepo ordersRepo;
//
//   ProfileBloc(this.ordersRepo) : super(const OrdersInitial());
//
//   @override
//   Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
//     if (event is GetOrders) {
//       try {
//         final ordersResponse = await ordersRepo.getOrder(event.id!);
//         if (ordersResponse.status == AppConstants.STATUS_SUCCESS &&
//             ordersResponse.data != null) {
//           yield OrdersLoaded(ordersResponse.data!);
//         } else {
//           yield OrdersError(ordersResponse.message!);
//         }
//       } on Error {
//         yield const OrdersError("Couldn't fetch weather. Is the device online?");
//       }
//     }
//
//   }
// }
