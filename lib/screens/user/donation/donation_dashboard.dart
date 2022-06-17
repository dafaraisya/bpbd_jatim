import 'dart:convert';
import 'dart:developer';

import 'package:bpbd_jatim/providers/donation_provider.dart';
import 'package:bpbd_jatim/screens/user/donation/checkout.dart';
import 'package:bpbd_jatim/screens/user/donation/confirmation.dart';
import 'package:bpbd_jatim/screens/user/donation/donation_amount.dart';
import 'package:bpbd_jatim/screens/user/donation/finalization.dart';
import 'package:bpbd_jatim/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationDashboard extends StatefulWidget {
  final String documentId;
  final String disasterName;

  const DonationDashboard({
    Key? key, 
    required this.documentId,
    required this.disasterName
  }) : super(key: key);

  @override
  State<DonationDashboard> createState() => _DonationDashboardState();
}

class _DonationDashboardState extends State<DonationDashboard> {
  static const List<Widget> _navigationOptions = [
    DonationAmount(),
    Checkout(),
    Confirmation(),
    Finalization(),
  ];

  final donationProvider = DonationProvider();

  getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(preferences.getString('user')!));
    setProviderData(user.id!, user.username!);
  }

  setProviderData(String userId, String username) {
    Provider.of<DonationProvider>(context, listen: false).changeDisasterName(widget.disasterName);
    Provider.of<DonationProvider>(context, listen: false).changeAccountName(username);
    Provider.of<DonationProvider>(context, listen: false).changeAccountId(userId);
    print(donationProvider.accountId);
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  void goBack() {
    setState(() {
      if (Provider.of<DonationProvider>(context, listen: false).donationIndex == 0) {
        Navigator.pop(context);
      } else {
        Provider.of<DonationProvider>(context, listen: false).changeIndex(
          Provider.of<DonationProvider>(context, listen: false).donationIndex - 1
        ) ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DonationProvider>(
        builder: (context, DonationProvider data, widget) {
      return Scaffold(
        body: _navigationOptions.elementAt(data.donationIndex),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    goBack();
                  },
                  child: SvgPicture.asset("assets/icons/back_black.svg"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Donasi',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
