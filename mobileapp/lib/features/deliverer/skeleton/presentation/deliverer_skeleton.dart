import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/deliverer/history/presentation/pages/deliveries_history.dart';
import 'package:mobileapp/features/deliverer/home/presentation/pages/deliverer_home_page.dart';
import 'package:mobileapp/features/deliverer/skeleton/presentation/widgets/deliverer_custom_top_bar.dart';
import 'package:mobileapp/core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DelivererSkeleton extends ConsumerStatefulWidget {
  const DelivererSkeleton({super.key});

  @override
  ConsumerState<DelivererSkeleton> createState() => _DelivererSkeletonState();
}

class _DelivererSkeletonState extends ConsumerState<DelivererSkeleton> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<String> _titles = ["Accueil", "Courses", "Historique"];

  final List<Widget> _pages = [
    DelivererHomePage(),
    Container(color: kPrimaryWhite),
    DeliveriesHistory(),
  ];

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider);
    final backgroundColor = isDarkMode ? kPrimaryBlack : kPrimaryWhite;

    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + height * 0.033),
        child: Container(
          color: backgroundColor,
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
        items: const [
          Icon(Icons.home, size: 30, color: kPrimaryWhite),
          Icon(Icons.motorcycle_rounded, size: 30, color: kPrimaryWhite),
          Icon(Icons.history, size: 30, color: kPrimaryWhite),
        ],
        color: kPrimaryRed,
        buttonBackgroundColor: kPrimaryRed,
        backgroundColor: backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: _setCurrentIndex,
      ),
    );
  }
}
