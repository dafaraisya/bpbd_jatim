import 'package:bpbd_jatim/components/app_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome Back,',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                  ),
                  const Icon(Icons.notification_add_outlined),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'BPBD Jawa Timur',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Peta persebaran bencana',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 241,
                width: double.infinity,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Data bencana',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
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
              const SizedBox(width: 15),
              Expanded(
                child: DefaultTabController(
                  length: 5,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Theme.of(context).colorScheme.primary,
                        labelStyle: Theme.of(context).textTheme.caption,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.secondary,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        tabs: const [
                          Tab(text: 'Semua'),
                          Tab(text: 'Kebakaran'),
                          Tab(text: 'Tanah longsor'),
                          Tab(text: 'Banjir'),
                          Tab(text: 'Gempa bumi'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            Center(),
                            Center(),
                            Center(),
                            Center(),
                            Center(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dummy extends StatelessWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1.1,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext ctx, index) {
          return AppCard(
            title: 'Kebakaran gedung',
            imageUrl: 'https://picsum.photos/200/300',
            street: 'Jl. Semarang surabaya',
            date: '20 Mei 2021',
            onTap: () {},
          );
        });
  }
}
