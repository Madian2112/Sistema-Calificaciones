import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/tables/tableshome_screen.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);
int num = 0;
class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  Future<bool> isAdmin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? numero = sharedPreferences.getInt('Numero');
    if(numero == 1){
      num = 1;
    }
    return numero == 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAdmin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final bool isAdmin = snapshot.data ?? false;
        final List<Widget> pages = [
          const HomeScreen(),
          const DashboardScreen(),
          if (isAdmin) const TablesScreen(),
          const ProfileScreen(),
        ];

        final List<BottomNavigationBarItem> bottomNavBarItems = [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          if (isAdmin)
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  inActiveIconColor,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                colorFilter: const ColorFilter.mode(
                  kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              label: "Chat",
            ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
        ];

        return Scaffold(
          body: pages[currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: updateCurrentIndex,
            currentIndex: currentSelectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: bottomNavBarItems,
          ),
        );
      },
    );
  }
}
