import 'package:bpbd_jatim/components/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailDisaster extends StatelessWidget {
  const DetailDisaster({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const DetailImage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *.65,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kebakaran gedung', style: Theme.of(context).textTheme.headline5,),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: const Icon(Icons.more_horiz_outlined),
                          ),
                        )
                      ],
                    ),
                    Text('Jl. Semarang surabaya', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Deskripsi', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                        const Label(text: 'Aktif',)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', textAlign: TextAlign.justify,),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          "20 Mei 2021",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          "12.00 WIB",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sumber Bantuan', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                        Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Tambah kategori',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const SumberBantuan(),
                    const SumberBantuan(),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Donasi Pengguna', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                        Text('Rp. 3.000.000', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const DonasiPengguna(),
                    const DonasiPengguna(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailImage extends StatefulWidget {
  const DetailImage({ Key? key }) : super(key: key);

  @override
  _DetailImageState createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/kebakaran_gedung_thumb.png'),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/back_black.svg",
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SumberBantuan extends StatelessWidget {
  const SumberBantuan({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor:const Color.fromARGB(255, 8, 214, 241),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color.fromARGB(255, 246, 94, 109),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'BPBD Jatim',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.surface),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Damkar Surabaya : 24 personil',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Divider(
                color: Color.fromARGB(123, 143, 149, 157),
                thickness: 1,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DonasiPengguna extends StatelessWidget {
  const DonasiPengguna({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.15))
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Liona firsyan',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).colorScheme.surface),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Rp. 1.500.000',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Lihat bukti >',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}