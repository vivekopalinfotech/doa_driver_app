// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class DashboardScreen extends StatefulWidget {
  final type;
  var online;
  final latitude;
  final longitude;

  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

   DashboardScreen(this.navigateToNext, this.openDrawer, this.online, {super.key, this.type,this.latitude,this.longitude});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _controller = ScrollController();
  late bool serviceEnabled;
   final PanelController _pc = PanelController();
  String latlng = "-1";
  final Completer<GoogleMapController> controller = Completer();
  LatLng? sourceLocation;

  static const LatLng destination = LatLng(23.03085995,72.53501535);
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/pin_source.png",)
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/pin_source.png")
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/cars.png")
        .then(
          (icon) {
        currentLocationIcon = icon;
      },
    );
  }
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.kGoogleApiKey, // Your Google Map Key
      PointLatLng(sourceLocation!.latitude!, sourceLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }


 LocationData? currentLocation;

  void getCurrentLocation() async {

    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
        sourceLocation = LatLng(
            currentLocation!.latitude!, currentLocation!.longitude!);
      },
    );

    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }
  @override
  void initState() {
    //getPolyPoints();
    getCurrentLocation();
    //getPolyPoints();
    setCustomMarkerIcon();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: widget.type == 'order' ? AppBar(
        elevation: 0,
        backgroundColor: AppStyles.MAIN_COLOR,
        iconTheme: const IconThemeData(color: AppStyles.SECOND_COLOR),
        title: const Text(
              "Delivery Map",
              // AppLocalizations.of(context)!.translate('app_name')!,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "MontserratBold",
                  fontWeight: FontWeight.bold,
                  color: AppStyles.SECOND_COLOR
              ),
            )

      ) : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
        controller: _pc,
        minHeight: widget.type == 'order'? 150 : 90,
        maxHeight: 290,
        onPanelOpened: () {

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
            child: widget.online == false? Column(
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
                            backgroundImage: NetworkImage('https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png',),
                          ),
                          const SizedBox(width: 12,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('${AppData.user!.firstName} ${AppData.user!.lastName}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text('Basic Level',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
                                  const Text(' | ',style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold,fontSize: 14),),
                                  Image.asset('assets/images/licence.png',height: 10,),
                                   const SizedBox(width: 3),
                                  Text('ACX ${AppData.user!.vehicle_registration_no}',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
                                ],
                              ),
                            ],),
                        ],
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
                          Icon(Icons.access_time_outlined,size: 45,color: AppStyles.SECOND_COLOR,),
                          Text('22',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                          Text("Today's Delivery",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/distance.png',height: 40,color: AppStyles.SECOND_COLOR,),
                          const Text('12',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                          const Text('Pending Delivery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/scooter.png',height: 40,color: AppStyles.SECOND_COLOR,),
                          const Text('40',style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.w500),),
                          const Text('Total Delivery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12),),
                        ],
                      )
                    ],
                  ),
                ),)
              ],
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
                                  //    widget.navigateToNext(OrderDetailScreen(navigateToNext: widget.navigateToNext, ordersData: '',));
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

                          showAlertDialog1(context);},
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
              currentLocation == null ? const Center(child: CircularProgressIndicator(
                color: AppStyles.MAIN_COLOR,
              )):

              //Text(currentLocation!.longitude!.toString()),
              GoogleMap(
                compassEnabled: false,
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(widget.latitude), double.parse(widget.longitude)),
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    icon: currentLocationIcon,
                    position: LatLng(
                        currentLocation!.latitude!, currentLocation!.longitude!),
                  ),
                   Marker(
                    markerId: const MarkerId("source"),
                    icon: sourceIcon,
                    position: sourceLocation!,
                  ),
                   Marker(
                    markerId: const MarkerId("destination"),
                    icon: destinationIcon,
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
                    color: AppStyles.MAIN_COLOR,
                    width: 4,

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
                                     backgroundColor: AppStyles.SECOND_COLOR,
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
                       ):Text(currentLocation!.latitude!.toString() + '===' + currentLocation!.longitude!.toString()),
             )
            ],
          ),
        ),
      ],
    );
  }
  void showAlertDialog1(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel",style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Start",style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold)),
      onPressed: ()  async {
        _pc.close();
        getPolyPoints();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Image.asset('assets/images/logo.png',height: 50,),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: const Text("Are You Ready For Start This Delivery?",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppStyles.MAIN_COLOR),),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

