import 'package:flutter/material.dart';
import 'package:travel_booking/constants/app_colors.dart' as appcolors;

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(
              double.infinity, kToolbarHeight + kTextTabBarHeight + 10),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            // title: Image.asset(height: kToolbarHeight, images.appLogo),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 0),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                height: kTextTabBarHeight,
                decoration:  BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: TabBar(
                    isScrollable: true,
                    // padding: EdgeInsets.only(left: 20, right: 20, top: 24),
                    labelColor: appcolors.tabBlue,
                    unselectedLabelColor: appcolors.grey_600,
                    indicatorColor: appcolors.tabBlue,
                    // // indicatorSize: TabBarIndicatorSize.tab,
                    indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    tabs: [
                      Tab(
                        child: Text("Hotels".toUpperCase()),
                      ),
                      Tab(
                        child: Text("Flights".toUpperCase()),
                      ),
                      Tab(
                        child: Text(
                          'Holiday Package'.toUpperCase(),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
        body:  TabBarView(children: [
          Container(),
          Container(),
          Container(),
          ]),
      ),
    );
  }
}
