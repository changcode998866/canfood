import 'package:flutter/material.dart';

import '../models/food_order.dart';
import '../theme/app_colors.dart';
import 'discover_page.dart';
import 'home_page.dart';
import 'orders_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  OrderFilter orderFilter = OrderFilter.all;

  void _navigateToTab(int index, {OrderFilter? filter}) {
    setState(() {
      currentIndex = index;
      if (index == 2) {
        orderFilter = filter ?? OrderFilter.all;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const DiscoverPage(),
      OrdersPage(initialFilter: orderFilter),
      ProfilePage(
        onNavigate: (index, {orderFilter = OrderFilter.all}) {
          _navigateToTab(index, filter: orderFilter);
        },
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        elevation: 8,
        onTap: (index) => _navigateToTab(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore_rounded),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long_rounded),
            label: '订单',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
