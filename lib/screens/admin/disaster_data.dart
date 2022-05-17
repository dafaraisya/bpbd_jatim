import 'package:bpbd_jatim/components/app_grid.dart';
import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/components/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_card.dart';

class DisasterData extends StatelessWidget {
  const DisasterData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      print("asdasd");
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/back_black.svg"),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Data Bencana',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 128,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: _onTap,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Download Data",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppGrid(
                      widgetList: [
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                        AppCard(
                            imageUrl: "http://placehold.jp/150x150.png",
                            title: "Data Bencana",
                            street: "4 Data",
                            date: "",
                            onTap: _onTap),
                      ],
                    ),
                  )
                ],
              )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                child: Button(
                  press: _onTap,
                  text: "Tambah Data",
                ),
              )
            ]),
          ),
        ));
  }
}
