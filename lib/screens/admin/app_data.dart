import 'package:bpbd_jatim/components/app_card.dart';
import 'package:bpbd_jatim/components/app_grid.dart';
import 'package:bpbd_jatim/screens/admin/account_data.dart';
import 'package:bpbd_jatim/screens/admin/disaster_data.dart';
import 'package:bpbd_jatim/screens/admin/donation_data.dart';
import 'package:bpbd_jatim/screens/admin/resource_data.dart';
import 'package:bpbd_jatim/screens/admin/resources_help.dart';
import 'package:flutter/material.dart';

class AppData extends StatelessWidget {
  const AppData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 16, 28, 0),
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
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/bpbd-jatim.appspot.com/o/data_bencana_thumb.png?alt=media&token=d7ae4c33-3db2-4970-8e9f-e9a58fe12a38",
                      title: "Data Bencana",
                      street: "Daftar semua bencana",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const DisasterData()))
                      }),
                  AppCard(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/bpbd-jatim.appspot.com/o/data_sumber_daya_thumb.png?alt=media&token=a336d39d-ab33-4b55-b291-b93943140fc7",
                      title: "Data Sumber Daya",
                      street: "Daftar semua sumber daya",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ResourceData()))
                      }),
                  AppCard(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/bpbd-jatim.appspot.com/o/data_akun_thumb.png?alt=media&token=0571dbe7-13ed-43e5-bdf5-88e58b0ada7e",
                      title: "Data Akun",
                      street: "Daftar semua akun",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountData()))
                      }),
                  AppCard(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/bpbd-jatim.appspot.com/o/sumber_bantuan_thumb.jpg?alt=media&token=4bd3b144-fdd5-45f2-9a86-0872f615f409",
                      title: "Data Sumber Bantuan",
                      street: "Daftar semua sumber bantuan",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ResourcesHelp()))
                      }),
                  AppCard(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/bpbd-jatim.appspot.com/o/donasi_thumb.jpg?alt=media&token=f1c02a4e-e70a-4a07-9b3b-4fdd61001f91",
                      title: "Data Donasi",
                      street: "Daftar semua donasi",
                      date: "",
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const DonationData()))
                      }),
                ]),
              ]),
            )
          ],
        ),
      )),
    );
  }
}
