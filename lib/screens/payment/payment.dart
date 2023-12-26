import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/bloc/payment/payment_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class Payment extends StatefulWidget {
  final amount;
  final type;
  final orderId;
  const Payment({super.key, this.amount, this.type, this.orderId});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController controller = TextEditingController();
  TextEditingController ccController = TextEditingController();

  void updateTextFieldValues(String value, int textFieldNumber) {
    setState(() {
      // Update the corresponding text field based on user input
      double enteredValue = double.tryParse(value) ?? 0.0;
      double remainingValue = double.parse(widget.amount) - enteredValue;
      if(remainingValue < 0){
        if (textFieldNumber == 1) {
          ccController.text = '0';
        } else {
          controller.text = '0';
        }
      }else{
        if (textFieldNumber == 1) {
          ccController.text = remainingValue.toString();
        } else {
          controller.text = remainingValue.toString();
        }
      }

    });
  }

  @override
  void initState() {
    print(widget.amount);
    if (widget.type == 'Cash') {
      controller.text = widget.amount.toString();
    } else if (widget.type == 'cc') {
      ccController.text = widget.amount.toString();
    } else {
      controller.text = (0).toString();
      ccController.text = (0).toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppStyles.MAIN_COLOR,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    )),
                Text(
                  ' Back',
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
          elevation: 0,
        ),
        body: BlocListener<PaymentBloc, PaymentState>(
            listener: (BuildContext context, state) {
              if (state is PaymentSuccess) {
                Loader.hide();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
                BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
              }
              if (state is PaymentFailed) {
                Loader.hide();
                showSnackBar(context, 'Error');
              }

              if (state is PaymentLoading) {
                loader(context);
              }

            },
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            '\$${widget.amount}',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
                          ),
                        ),
                        const Divider(
                          height: 32,
                          color: Colors.black38,
                        ),
                        widget.type == 'Cash' || widget.type == 'split'
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/money.png',
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        const Text(
                                          'Cash',

                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                                        )
                                      ],
                                    ),
                                    widget.type == 'split'
                                        ? SizedBox(
                                            width: 60,
                                            child: TextField(
                                              onChanged: (value) {
                                                updateTextFieldValues(value, 1);
                                              },
                                              keyboardType: TextInputType.number,
                                              controller: controller,
                                              decoration: const InputDecoration(
                                                  prefix: Text(
                                                '\$ ',
                                                style: TextStyle(color: Colors.black),
                                              )),
                                            ))
                                        : Text(
                                            '\$${widget.amount}',
                                            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                                          )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        widget.type == 'Cash' || widget.type == 'split' ? const Divider() : const SizedBox(),
                        widget.type == 'cc' || widget.type == 'split'
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/credit-card-machine.png',
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        const Text(
                                          'CC Terminal',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                                        )
                                      ],
                                    ),
                                    widget.type == 'split'
                                        ? SizedBox(
                                            width: 60,
                                            child: TextField(
                                              onChanged: (value) {
                                                updateTextFieldValues(value, 2);
                                              },
                                              keyboardType: TextInputType.number,
                                              controller: ccController,
                                              decoration: const InputDecoration(
                                                  prefix: Text(
                                                '\$ ',
                                                style: TextStyle(color: Colors.black),
                                              )),
                                            ))
                                        : Text(
                                            '\$${widget.amount}',
                                            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                                          )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        widget.type == 'cc' || widget.type == 'split' ? const Divider() : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              widget.type == 'split' && isSumEqualToTotalValue()
                  ? Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            var cash = controller.text == '' ? '0' : controller.text;

                            var cc = ccController.text == '' ? '0' : ccController.text;
                            BlocProvider.of<PaymentBloc>(context).add(CheckPayment(widget.orderId.toString(), 'Delivered', double.parse(cash), double.parse(cc)));
                          },
                          child: Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppStyles.MAIN_COLOR,
                            ),
                            child: const Center(
                              child: Text(
                                'Mark as Paid',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : widget.type == 'Cash' || widget.type == 'cc'
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                widget.type == 'Cash'
                                    ? BlocProvider.of<PaymentBloc>(context).add(CheckPayment(widget.orderId.toString(), 'Delivered', double.parse(controller.text), 0))
                                    : BlocProvider.of<PaymentBloc>(context).add(CheckPayment(widget.orderId.toString(), 'Delivered', 0, double.parse(ccController.text)));
                              },
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: AppStyles.MAIN_COLOR,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Mark as Paid',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
            ])));
  }

  bool isSumEqualToTotalValue() {
    double value1 = double.tryParse(controller.text) ?? 0.0;
    double value2 = double.tryParse(ccController.text) ?? 0.0;

    return (value1 + value2) == double.parse(widget.amount);
  }
}
