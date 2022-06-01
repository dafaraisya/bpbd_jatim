import 'package:bpbd_jatim/components/app_card.dart';
import 'package:bpbd_jatim/components/app_grid.dart';
import 'package:bpbd_jatim/screens/admin/disaster_data.dart';
import 'package:bpbd_jatim/screens/admin/resource_data.dart';
import 'package:flutter/material.dart';

class AppData extends StatelessWidget {
  const AppData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DisasterData()));
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Data Aplikasi",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
            ),
            Expanded(
              child: ListView(children: [
                AppGrid(widgetList: [
                  AppCard(
                      imageUrl: "http://placehold.jp/150x150.png",
                      title: "Data Bencana",
                      street: "4 Data",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const DisasterData()))
                      }),
                  AppCard(
                      imageUrl: "http://placehold.jp/150x150.png",
                      title: "Data Sumber Daya",
                      street: "3 Data",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ResourceData()))
                      }),
                  AppCard(
                      imageUrl: "http://placehold.jp/150x150.png",
                      title: "Data Akun",
                      street: "2 Data",
                      date: "",
                      onTap: _onTap),
                ]),
              ]),
            )
          ],
        ),
      )),
    );
  }
}
