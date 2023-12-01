import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/payment/payment.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final amount;
  final orderId;
  const PaymentScreen({super.key, this.amount, this.orderId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppStyles.MAIN_COLOR,
        leadingWidth: 80,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
              Text(' Back',
                textScaleFactor: 1,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          '\$${widget.amount}',
          style: const TextStyle(fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'How would you like to play?',
                        style: TextStyle(color: Colors.black38, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(amount:  widget.amount,type: 'Cash',orderId: widget.orderId,)));
                        },
                        child: Row(
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
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(amount:  widget.amount,type: 'cc',orderId: widget.orderId)));
                        },
                        child: Row(
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
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(amount:  widget.amount,type: 'split',orderId: widget.orderId)));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/split.png',
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text(
                              'Split',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppStyles.MAIN_COLOR),
                  ),
                  child: const Center(
                    child: Text(
                      'Back',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: AppStyles.MAIN_COLOR),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
