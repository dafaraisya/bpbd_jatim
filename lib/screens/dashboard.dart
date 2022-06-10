import 'package:bpbd_jatim/screens/admin/app_data.dart';
import 'package:bpbd_jatim/screens/home.dart';
import 'package:bpbd_jatim/screens/profile.dart';
import 'package:bpbd_jatim/screens/user/donation/history_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../globals.dart' as globals;

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
          icon = "assets/icons/profile_orange.svg";
        } else {
          icon = "assets/icons/profile_white.svg";
        }
        break;
      default:
        icon = "";
    }
    return icon;
  }

  Widget _buildIcon(String text, int index) => SizedBox(
        width: 100,
        height: 50,
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
      );

  Widget _getScreen(index) {
    if(globals.isAdmin) {
      if (index == 1) {
        return Home();
      } else if (index == 2) {
        return const Profile();
      }
      return const AppData();
    } else {
      if (index == 1) {
        return Home();
      } else if (index == 2) {
        return const Profile();
      }
      return const HistoryDonation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(child: _getScreen(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          items: globals.isAdmin ? 
          <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: _buildIcon('Data', 0), label: ''),
            BottomNavigationBarItem(icon: _buildIcon('Home', 1), label: ''),
            BottomNavigationBarItem(icon: _buildIcon('Profile', 2), label: ''),
          ] : <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: _buildIcon('Histori', 0), label: ''),
            BottomNavigationBarItem(icon: _buildIcon('Home', 1), label: ''),
            BottomNavigationBarItem(icon: _buildIcon('Profile', 2), label: ''),
          ] 
        ),
      ),
    );
  }
}
