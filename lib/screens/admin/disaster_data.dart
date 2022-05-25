import 'package:bpbd_jatim/components/app_grid.dart';
import 'package:bpbd_jatim/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../components/app_card.dart';

class DisasterData extends StatelessWidget {
  const DisasterData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PanelController _pc = PanelController();

    void _onTap() {
      print("asdasd");
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => {
                          Navigator.pop(context)
                        },
                        child: SvgPicture.asset("assets/icons/back_black.svg"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Data Bencana',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
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
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  width: double.infinity,
                  child: Button(
                    press: () => _pc.open(),
                    text: "Tambah Data",
                  ),
                )
              ]),
            ),
          ),
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            panel: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: InkWell(
                              onTap: () => _pc.close(),
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.surface,
                                size: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Tambah Data Bencana",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 32,
                    thickness: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.25),
                                prefixIcon: const Icon(Icons.star),
                                prefixIconColor: Colors.amber,
                                hintText: "Nama Bencana"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.25),
                                prefixIcon: const Icon(Icons.star),
                                prefixIconColor: Colors.amber,
                                hintText: "Tanggal Bencana"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.25),
                                prefixIcon: const Icon(Icons.star),
                                prefixIconColor: Colors.amber,
                                hintText: "Waktu Bencana"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.25),
                                prefixIcon: const Icon(Icons.star),
                                prefixIconColor: Colors.amber,
                                hintText: "Titik Lokasi"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.25),
                                prefixIcon: const Icon(Icons.star),
                                prefixIconColor: Colors.amber,
                                hintText: "Status"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            press: () => _pc.open(),
                            text: "Tambah Data",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            minHeight: 0,
            controller: _pc,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ],
      ),
    );
  }
}
