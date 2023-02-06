import 'package:clockapp/data/data.dart';
import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/helpers/enums.dart';
import 'package:clockapp/screens/alarm_page.dart';
import 'package:clockapp/screens/clock_page.dart';
import 'package:clockapp/theme/theme_data.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../views/clock_view.dart';

class HomePage extends StatefulWidget {
  static const routeID = "/homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((e) => buildMenuButton(e)).toList(),
          ),
          const VerticalDivider(
            color: Colors.white24,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, child) {
                if (value.menuType == MenuType.clock) {
                  return const ClockPage();
                } else if (value.menuType == MenuType.alarm) {
                  return const AlarmPage();
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (
        BuildContext context,
        MenuInfo value,
        Widget? child,
      ) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(28),
              ),
            ),
            backgroundColor: currentMenuInfo.menuType == value.menuType
                ? CustomColors.menuBackgroundColor
                : Colors.transparent,
          ),
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(
              context,
              listen: false,
            );
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: [
              Image.asset(
                currentMenuInfo.imageSource!,
                scale: 1.5,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                currentMenuInfo.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "avenir",
                  fontSize: 14,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
