import 'package:bpbd_jatim/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ResourceData extends StatelessWidget {
  const ResourceData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onDownloadButtonPressed() {
      print("asdasd");
    }

    final PanelController _pc = PanelController();

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            'Data sumber daya',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 148,
                      height: 36,
                      child: OutlinedButton(
                        onPressed: _onDownloadButtonPressed,
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
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ResourceCard();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Button(
                      text: 'Tambah data',
                      press: () => _pc.open(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
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
                              "Tambah Sumber Daya",
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
                                hintText: "Nama Sumber Daya"),
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
                                hintText: "Upload Gambar"),
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

class ResourceCard extends StatelessWidget {
  const ResourceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://picsum.photos/200/300',
                  width: 47,
                  height: 44,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Damkar surabaya',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Aktif',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const CustomSwitch(),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 32.0,
      height: 15.0,
      toggleSize: 11.0,
      activeToggleColor: Theme.of(context).colorScheme.primary,
      activeColor: const Color(0xFFD5DBE1),
      inactiveColor: const Color(0xFFD5DBE1),
      value: status,
      borderRadius: 30.0,
      padding: 3.0,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    );
  }
}
