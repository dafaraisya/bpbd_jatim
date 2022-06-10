import 'package:bpbd_jatim/components/app_card.dart';
import 'package:bpbd_jatim/screens/admin/detail_disaster.dart';
import 'package:bpbd_jatim/screens/user/detail_disaster_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../globals.dart' as globals;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PanelController _pc = PanelController();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome Back,',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
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
                      const SizedBox(height: 20),
                      Text(
                        'Peta persebaran bencana',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height/4.2,
                        width: double.infinity,
                        color: Colors.black,
                        child: const MapView(),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              panel: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
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
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                              indicatorColor:
                                  Theme.of(context).colorScheme.primary,
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
                                  Dummy(),
                                  Dummy(),
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
              minHeight: MediaQuery.of(context).size.height/2.6,
              controller: _pc,
              parallaxOffset: 0.5,
              parallaxEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-7.256673058845434, 112.75218079053529);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 12.0,
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
        childAspectRatio: 1 / 1.2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext ctx, index) {
        return AppCard(
          title: 'Kebakaran gedung',
          imageUrl: 'assets/images/kebakaran_gedung_thumb.png',
          street: 'Jl. Semarang surabaya',
          date: '20 Mei 2021',
          onTap: () {
            if(globals.isAdmin) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailDisaster()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailDisasterUser()));
            }
          },
        );
      });
  }
}
