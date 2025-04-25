import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/core/config/dark_mode_provider.dart';
import 'package:mobileapp/features/customer/coupons_store/presentation/pages/Coupon_page.dart';
import 'package:mobileapp/features/customer/skeleton/presentation/widgets/customer_custom_top_bar.dart';
import 'package:mobileapp/core/constants/constants.dart';

class CustomerSkeleton extends ConsumerStatefulWidget {
  const CustomerSkeleton({super.key});

  @override
  ConsumerState<CustomerSkeleton> createState() => _CustomerSkeletonState();
}

class _CustomerSkeletonState extends ConsumerState<CustomerSkeleton> {
  int _currentIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<String> _titles = [
    "Accueil",
    "Restaurants",
    "Courses",
    "Favoris",
    "Coupons",
  ];
  final List<Widget?> _pages = [
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
    Container(color: kPrimaryWhite),
    null,
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
    final isDarkMode = ref.watch(darkModeProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + height * 0.033),
        child: Container(
          color: isDarkMode ? kPrimaryDark : kSecondaryWhite,
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: MyPainter(),
            child: CustomTopBar(title: _titles[_currentIndex]),
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(_pages.length, (index) {
          if (index == 4 && _currentIndex == 4) {
            return const CouponPage();
          }
          return _pages[index] ?? Container();
        }),
      ),
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
        backgroundColor: isDarkMode ? kPrimaryDark : kSecondaryWhite,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: _setCurrentIndex,
      ),
    );
  }
}
