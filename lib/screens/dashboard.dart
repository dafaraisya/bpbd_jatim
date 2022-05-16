import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getBgColor(int index) => _selectedIndex == index
      ? Theme.of(context).colorScheme.background
      : Theme.of(context).colorScheme.primary;

  Color _getItemColor(int index) => _selectedIndex == index
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.background;

  String _getItemIcon(int index) {
    String icon = "";
    switch (index) {
      case 0:
        if (_selectedIndex == index) {
          icon = "assets/icons/data_orange.svg";
        } else {
          icon = "assets/icons/data_white.svg";
        }
        break;
      case 1:
        if (_selectedIndex == index) {
          icon = "assets/icons/home_orange.svg";
        } else {
          icon = "assets/icons/home_white.svg";
        }
        break;
      case 2:
        if (_selectedIndex == index) {
          icon = "assets/icons/home_orange.svg";
        } else {
          icon = "assets/icons/home_white.svg";
        }
        break;
      default:
        icon = "";
    }
    return icon;
  }

  Widget _buildIcon(IconData iconData, String text, int index) => SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Material(
            borderRadius: BorderRadius.circular(100),
            color: _getBgColor(index),
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(_getItemIcon(index)),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 12,
                      color: _getItemColor(index),
                    ),
                  ),
                ],
              ),
              onTap: () => _onItemTapped(index),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: _buildIcon(Icons.home, 'Data', 0), label: ''),
            BottomNavigationBarItem(
                icon: _buildIcon(Icons.home, 'Home', 1), label: ''),
            BottomNavigationBarItem(
                icon: _buildIcon(Icons.home, 'Profile', 2), label: ''),
          ],
        ),
      ),
    );
  }
}
