// ignore_for_file: library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables, no_logic_in_create_state
import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/shifts/shifts_screen.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'screens/history/historyscreen.dart';
import 'screens/order/orderscreen.dart';
import 'screens/settings/settingscreen.dart';
import 'utils/widgets/bottomnavigation.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  final lat;
  final lng;

  TabController? controller;
  MainScreen({super.key, this.lat, this.lng});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late bool serviceEnabled;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>()];

  _MainScreenState();

  String latitude = "";
  String longitude = "";
  Future<void> _callSplashScreen() async {
    Position position = await _getGeoLocationPosition();
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }

  Future<Position> _getGeoLocationPosition() async {
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } else {

    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _callSplashScreen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callSplashScreen();
  }

  final keyCounter = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {
          return isFirstRouteInCurrentTab;
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              elevation: 0,
              toolbarHeight: 60,
              backgroundColor: AppStyles.MAIN_COLOR,
              leading: Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  // onTap: () => _openHomeDrawer(),
                  onTap: () => showAlertDialog1(context),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      "assets/images/menu.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: _selectedIndex == 1
                  ? const Center(child: Text('AM'))
                  : Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppStyles.SECOND_COLOR),
                      child: TabBar(
                        tabs: const [
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Incomplete',textScaleFactor: 1,),
                          )),
                          Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Completed',textScaleFactor: 1
                            ),
                          )),
                        ],
                        unselectedLabelColor: AppStyles.MAIN_COLOR,
                        labelColor: Colors.white,
                        indicatorPadding: EdgeInsets.zero,
                        indicator: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppStyles.MAIN_COLOR),
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),

              actions: [

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToNext(SettingScreen(navigateToNext: _navigateToNext));
                    },
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        "assets/images/settings.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
            ],
          ),
          bottomNavigationBar: SizedBox(height: 70, child: MyBottomNavigation(_selectCurrentItem, _selectedIndex)),
        ),
      ),
    );
  }

  void showAlertDialog1(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
        );
        BlocProvider.of<AuthBloc>(context).add(const PerformLogout());
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: const Text(
              "Are You Sure You Want to Logout?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.MAIN_COLOR),
            ),
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

  void _selectCurrentItem(int position) {
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _homeScreenRouteBuilder(context, index);
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val) => setState(() {}));
  }

  _navigateToNextRemoveUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false).then((value) => setState(() {}));
  }

  _openHomeDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          TabBarView(children: [
            OrderScreen(_navigateToNext, _openHomeDrawer, widget.lat ?? latitude, widget.lng??longitude),
            HistoryScreen(
              _navigateToNext,
              _openHomeDrawer,
              lat: widget.lat ?? latitude,
              lng: widget.lng??longitude
            ),
          ]),
          //   OrderScreen(_navigateToNext, _openHomeDrawer,online,latitude,longitude),

          ShiftScreen(
            navigateToNext: _navigateToNext,
            navigateToRemoveUntil: _navigateToNextRemoveUntil,
            openDrawer: _openHomeDrawer,
          ),
        ].elementAt(index);
      },
    };
  }
}
