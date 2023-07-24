// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';



class DashboardScreen extends StatefulWidget {
  final type;
  var online;
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

   DashboardScreen(this.navigateToNext, this.openDrawer, this.online, {super.key, this.type});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _controller = ScrollController();
  //
   final PanelController _pc = PanelController();

  final Completer<GoogleMapController> controller = Completer();
  static const LatLng sourceLocation = LatLng(23.02985991,72.52504161);
  static const LatLng destination = LatLng(23.0307925,72.5603854);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
     AppConstants.kGoogleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
  }
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
    (location) {
        currentLocation = location;
      },
    );
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        const CameraPosition(target: LatLng(23.0298599,72.5250416),zoom: 20.5 );
      },
    );
  }

  @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();
    super.initState();
  }

  _openHomeDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: widget.type != 'order' ? AppBar(
        elevation: 0,
        backgroundColor: AppStyles.MAIN_COLOR,
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () => _openHomeDrawer(),
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset("assets/images/menu.png",
                  scale: 2.5,
                  color: Colors.white,
                  fit: BoxFit.none),
            ),
          ),
        ),
        title:  Center(
            child: Text(
              widget.online == false? "Offline": "Online",
              // AppLocalizations.of(context)!.translate('app_name')!,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: "MontserratBold",
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            )),
        actions: [
          Padding( padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FlutterSwitch(
            activeSwitchBorder: Border.all(color: Colors.white),
            activeColor: AppStyles.MAIN_COLOR,
            width: 45.0,
            height: 30.0,
            valueFontSize: 12.0,
            toggleSize: 20.0,
            value: widget.online ,
            borderRadius: 20.0,
            padding: 5.0,
            showOnOff: false,
            onToggle: (val) {
              setState(() {
                widget.online  = val;
              });
            },
          ),
        )]
      ) : AppBar(
        backgroundColor: AppStyles.MAIN_COLOR,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Delivery Map',style: TextStyle(color: Colors.white),),
      ),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        controller: _pc,
        minHeight: widget.type == 'order'? 150 : 90,
        maxHeight: 290,
        onPanelOpened: () {
          setState(() {});
          },
        panelBuilder: (ScrollController sc) {
          _controller = sc;
          return _scrollingList();
        },
        body: MapDisplay(context),
      ),
    );

  }
  Widget _scrollingList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onVerticalDragStart: (details) {
            if (_pc.isPanelOpen) {
              _pc.close();
            } else {
              _pc.open();
            }
          },
          child: Container(
            height: 8.0,
            width: 60.0,
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        Expanded(
          child : SingleChildScrollView(
            controller: _controller,
            child: widget.online == false? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white,AppStyles.SECOND_COLOR.withOpacity(.8),AppStyles.SECOND_COLOR.withOpacity(.9),AppStyles.SECOND_COLOR],begin: AlignmentDirectional.topCenter,end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/smile-confidence-young-man-professional-260nw-1801689064.jpg',),
                            ),
                            const SizedBox(width: 12,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Mike Jones',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text('Basic Level',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
                                    const Text(' | ',style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold,fontSize: 14),),
                                    Image.asset('assets/images/licence.png',height: 10,),
                                    const SizedBox(width: 3),
                                    Text('ACX 7518',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
                                  ],
                                ),


                              ],),

                          ],

                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.end,
                            children:  [
                              const Text('\$371.00',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                              const SizedBox(height: 5,),
                              Text('Earned',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
                              const SizedBox(height: 5,),
                            ],),
                        ),
                      ),
                    ],
                  ),
                ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppStyles.MAIN_COLOR
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.access_time_outlined,size: 45,color: AppStyles.NEW_COLOR,),
                            Text('8.5',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                            Text('Hours Online',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/distance.png',height: 35,),
                            const Text('10.5 km',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                            const Text('Total Distance',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/scooter.png',height: 35,),
                            const Text('40',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                            const Text('Total Delivery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                          ],
                        )
                      ],
                    ),
                  ),)
                ],
              ),
            ):Container(
              height: 260,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 10,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/images/profile.jpg',),
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text('Dank of America',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                    Text('OBD Store',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 14),),
                                  ],),
                              ],),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            width: 110,
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.end,
                              children:  [
                                const Text('\$230.00',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                const Text('2.5 km',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                                InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: (){
                                      widget.navigateToNext(OrderDetailScreen(navigateToNext: widget.navigateToNext));
                                    },
                                    child: const Text('Order Details >',style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold,fontSize: 11),)),
                              ],),
                          ),
                        ),
                      ],
                    ),
                    const Text('Pick Up',
                      style: TextStyle(color: Colors.grey,fontSize: 12),),
                    const SizedBox(
                      width: 250,
                      child: Text('123,ABC Building,Near Mall Road...',
                        style: TextStyle(color: Colors.black,fontSize: 14),),
                    ),
                    const Text('Drop Off',
                      style: TextStyle(color: Colors.grey,fontSize: 12),),
                    const SizedBox(
                      width: 250,
                      child: Text('3rd Floor, william street, Twin Tower ',
                        style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,),
                    ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                         _pc.close();
                        },
                        child: Container(
                          height: 45,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppStyles.MAIN_COLOR,
                              boxShadow: const [
                                BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 4)
                              ]
                          ),
                          child: const Center(child: Text('Start Delivery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                            ),),),
                        ),
                      ),
                  ],
                ),
              ),
            )
          )
        ),
      ],
    );
  }

  Widget MapDisplay(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Platform.isIOS? MediaQuery.of(context).size.height- 285:
          MediaQuery.of(context).size.height- 235,
          child: Stack(
            children: [
              GoogleMap(
                compassEnabled: false,
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: sourceLocation,
                  zoom: 15.0,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId("currentLocation"),
                    position: sourceLocation),
                  const Marker(
                    markerId: MarkerId("source"),
                    position: sourceLocation,
                  ),
                  const Marker(
                    markerId: MarkerId("destination"),
                    position: destination,
                  ),
                },
                onMapCreated: (mapController) {
                  controller.complete(mapController);
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: AppStyles.BOTTOM_COLOR,
                    width: 6,
                  ),
                },
                myLocationButtonEnabled: true,
                tiltGesturesEnabled: true,
                onCameraIdle: () {},
                onCameraMove: (position) {},
              ),
             Positioned(
               child:
                       widget.online == false && widget.type != 'order'?
                       Container(
                         height: 75,
                         color: AppStyles.MAIN_COLOR,
                         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                         child: Row(
                           children: [
                             Flexible(
                               flex: 1,
                               child: DottedBorder(
                                 padding: const EdgeInsets.all(3),
                                   borderType: BorderType.Circle,
                                   child:  CircleAvatar(
                                     radius: 20,
                                     backgroundColor: AppStyles.NEW_COLOR,
                                     child: Image.asset('assets/images/offline.png',height: 25,)
                                   )),
                             ),
                             const SizedBox(
                               width: 10,
                             ),
                             Flexible(
                                 flex: 6,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: const [
                                     Text(
                                       'You are offline.!',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 16),
                                     ),
                                     SizedBox(height: 5,),
                                     Text(
                                       'Go online to start accepting orders',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 12),
                                     )
                                   ],
                                 ))
                           ],
                         ),
                       ):const SizedBox(height: 0,),
             )
            ],
          ),
        ),
      ],
    );
  }

}

