import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobileapp/features/auth/presentation/pages/login_page.dart';
import 'package:mobileapp/features/gesProfil/DevCommercant/presentation/pages/trader_first_page.dart';
import 'package:mobileapp/features/gesProfil/DevCommercant/presentation/pages/trader_second_page.dart';
import 'package:mobileapp/features/gesProfil/DevCommercant/presentation/pages/trader_third_page.dart';

class BeTraderSkeleton extends StatefulWidget {
  const BeTraderSkeleton({super.key});

  @override
  State<BeTraderSkeleton> createState() => _BeTraderSkeletonState();
}

class _BeTraderSkeletonState extends State<BeTraderSkeleton> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex++);
    }
  }

  void previousPage() {
    print("gggg");
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() => _currentIndex--);
    } else {
      
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          onPressed: () {
            // Utilisez Navigator.push pour naviguer vers LoginPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        title: Text(
          'Devenir commerçant',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          TradeFirstPage(onNext: nextPage),
          TraderSecondPage(onNext: nextPage, onPrevious: previousPage),
          TraderThirdPage(onNext: () {}, onPrevious: previousPage),
        ],
      ),
    );
  }
}
