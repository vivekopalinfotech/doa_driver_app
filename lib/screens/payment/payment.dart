import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {

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
      body: BlocConsumer<OrderStatusBloc, OrderStatusState>(listener: (context, state) async {
        if (state is OrderStatusSuccess) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => false);
        }
        if (state is OrderStatusFailed) {
          showSnackBar(context, 'Error');
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          widget.type == 'split' ? '\$${widget.amount}' : '${widget.amount}',
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
                                              setState(() {
                                                controller.text = (widget.amount - ccController.text).toString();
                                              });
                                            },
                                            controller: controller,
                                            decoration: const InputDecoration(
                                                prefix: Text(
                                              '\$ ',
                                              style: TextStyle(color: Colors.black),
                                            )),
                                          ))
                                      : Text(
                                          '${widget.amount}',
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
                                              setState(() {
                                                ccController.text = widget.amount - controller.text;
                                              });
                                            },
                                            controller: ccController,
                                            decoration: const InputDecoration(
                                                prefix: Text(
                                              '\$ ',
                                              style: TextStyle(color: Colors.black),
                                            )),
                                          ))
                                      : Text(
                                          '${widget.amount}',
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
            controller.text + ccController.text == widget.amount
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
                          BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.orderId.toString(), 'Delivered'));
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
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
