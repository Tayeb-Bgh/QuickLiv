import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/features/deliverer/skeleton/presentation/widgets/deliverer_custom_top_bar.dart';
import 'package:mobileapp/core/constants/constants.dart';

class DelivererSkeleton extends StatefulWidget {
  const DelivererSkeleton({super.key});

  @override
  State<DelivererSkeleton> createState() => _DelivererSkeletonState();
}

class _DelivererSkeletonState extends State<DelivererSkeleton> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<String> _titles = ["Accueil", "Courses", "Historique"];

  final List<Widget> _pages = [
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
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
          const Icon(Icons.motorcycle_rounded, size: 30, color: kPrimaryWhite),
          const Icon(Icons.history, size: 30, color: kPrimaryWhite),
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
