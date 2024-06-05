import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCard extends StatefulWidget {
  final OrdersData ordersData;
  final Function(bool) callback;
  final miles;
  const DetailCard({super.key, required this.ordersData, this.miles, required this.callback});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  Future<void> _makePhoneCall(String phone) async {
    final Uri launchUri = Uri.parse('tel:$phone');
    await launchUrl(launchUri);
  }

  Future<void> _textMsg(String phone) async {
    final Uri launchUri = Uri.parse('sms:$phone');
    await launchUrl(launchUri);
  }

  bool isZoom = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        if(widget.ordersData.customerId!.customer_proof!=null){
                          isZoom = true;
                          widget.callback(isZoom);
                        }


                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: 'https://admin.rkdeliveries.com/proof/${widget.ordersData.customerId!.customer_proof ?? ''}',
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator(color: Colors.white, backgroundColor: AppStyles.MAIN_COLOR, value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Image.asset('assets/images/customer_logo.png',
                              height: 40
                            ),
                          ),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppUtils.capitalizeFirstLetter('${widget.ordersData.customerId!.customer_first_name ?? ''} ${widget.ordersData.customerId!.customer_last_name ?? ''}'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      //  const SizedBox(height: 5,),
                      Text(
                        widget.ordersData.warehouse!.warehouse_name ?? '',
                        style: const TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      //  const SizedBox(height: 5,),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black38,
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Notes: ',
                            style: TextStyle(color: Colors.black26, fontSize: 14),
                          ),
                          Flexible(
                            child: Text(
                              widget.ordersData.customer_order_notes != 'null' ? widget.ordersData.customer_order_notes.toString() : '',
                              style: const TextStyle(
                                fontSize: 14,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.red,fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Created At: ',
                            style: TextStyle(color: Colors.black26, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: Text(
                              '${AppUtils.convertDate(widget.ordersData.order_date ?? '')}, ${AppUtils.convertTime(widget.ordersData.order_time ?? '')}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivery Time: ',
                            style: TextStyle(color: Colors.black26, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: Text(
                              widget.ordersData.delivery_time.toString() != 'null'? widget.ordersData.delivery_time.toString(): "N/A",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _textMsg(widget.ordersData.billing_phone ?? '');
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppStyles.MAIN_COLOR,
                        child: Icon(
                          Icons.message_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _makePhoneCall(widget.ordersData.billing_phone ?? '');
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppStyles.MAIN_COLOR,
                        child: Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
