import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/pages/Coupon_page.dart';
import 'package:mobileapp/features/maps_example/polyline_origin_to_destination.dart';

import 'package:mobileapp/features/example/presentation/pages/presentation_page.dart';

import 'package:mobileapp/features/customer/skeleton/presentation/widgets/custom_top_bar.dart';
import 'package:mobileapp/core/constants/constants.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<String> _titles = [
    "Accueil",
    "Restaurants",
    "Courses",
    "Favoris",
    "Coupons",
  ];

  final List<Widget> _pages = [
    ExamplePage(),
    GoogleMapsPage(),
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
    CouponPage(), // ← ici on remplace par la vraie page
  ];

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + height * 0.033),
        child: Container(
          color: kPrimaryWhite,
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: MyPainter(),
            child: CustomTopBar(title: _titles[_currentIndex]),
          ),
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentIndex,
        height: 49.0,
        items: <Widget>[
          const Icon(Icons.home, size: 30, color: kPrimaryWhite),
          const Icon(Icons.fastfood, size: 30, color: kPrimaryWhite),
          SvgPicture.asset(
            'assets/images/market.svg',
            width: 28,
            height: 28,
            color: kPrimaryWhite,
          ),
          const Icon(Icons.favorite, size: 30, color: kPrimaryWhite),
          SvgPicture.asset(
            'assets/images/coupon.svg',
            width: 35,
            height: 35,
            color: kPrimaryWhite,
          ),
        ],
        color: kPrimaryRed,
        buttonBackgroundColor: kPrimaryRed,
        backgroundColor: kPrimaryWhite,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: _setCurrentIndex,
      ),
    );
  }
}
