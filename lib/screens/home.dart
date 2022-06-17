import 'dart:convert';

import 'package:bpbd_jatim/components/app_card.dart';
import 'package:bpbd_jatim/screens/admin/detail_disaster.dart';
import 'package:bpbd_jatim/screens/user/detail_disaster_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences preferences;
  dynamic user = null;

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      setState((){
        user = preferences.getString('user') != null ? jsonDecode(preferences.getString("user")!) : null;
        if(user['privilege'] == 'admin') {
          globals.isAdmin = true;
        } else {
          globals.isAdmin = false;
        }
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController createCategoryController = TextEditingController();
  String? newCategory;
  
  Future<void> createCategoryDisaster() async {
    try {
      await firestore.collection('disasterCategories').add({
        'categoryName': newCategory,
        'date' : Timestamp.now()
      });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future<void> createCategoryDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Kategori Bencana'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newCategory = value;
              });
            },
            style: const TextStyle(
              color: Colors.black
            ),
            controller: createCategoryController,
            decoration: const InputDecoration(hintText: "Masukkan Kategori Bencana",),
          ),
          actions: <Widget>[
            FlatButton(
              color: Theme.of(context).colorScheme.secondaryContainer,
              textColor: Colors.white,
              child: const Text('Batalkan'),
              onPressed: () {
                setState(() {
                  newCategory = '';
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Masukkan'),
              onPressed: () {
                createCategoryDisaster();
                Navigator.pop(context);
              },
            ),

          ],
        );
      });
  }

  @override
  void initState() {
    getUserData();
    super.initState(); 
  }

  @override
  void dispose() {
    createCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Stream lala = DatabaseService().streamDisasterCategories();
    // log('$lala');
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
                        user != null ? user['username'] : 'Memuat...',
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
                        InkWell(
                          onTap: () {
                            createCategoryDialog(context);
                          },
                          child: Row(
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
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                          .collection("disasterCategories")
                          .orderBy('date', descending: false)
                          .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                          if(snapshot.hasData) {
                            if(snapshot.data!.docs.isNotEmpty) {
                              return DefaultTabController(
                                length: snapshot.data!.docs.length,
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
                                      tabs: List.generate(snapshot.data!.docs.length, (index) => Tab(
                                        text: snapshot.data!.docs[index]["categoryName"] == 'Pilih Kategori Bencana' ? 'Semua' : snapshot.data!.docs[index]["categoryName"] 
                                      ))
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: TabBarView(
                                        children: List.generate(snapshot.data!.docs.length, (index) => DisasterDataList(
                                          disasterCategory: snapshot.data!.docs[index]["categoryName"],
                                        ))
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } 
                          return const Center(child: CircularProgressIndicator());
                        }
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

class DisasterDataList extends StatelessWidget {
  final String? disasterCategory;

  const DisasterDataList({Key? key, this.disasterCategory}) : super(key: key);

  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: disasterCategory == 'Pilih Kategori Bencana' ? FirebaseFirestore.instance
        .collection("disasters")
        .snapshots() : 
      FirebaseFirestore.instance
        .collection("disasters")
        .where("disasterCategory", isEqualTo: disasterCategory)
        .snapshots(),
      builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data!.docs.isEmpty) {
            return const Text('Belum Ada Data', textAlign: TextAlign.center,);
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1 / 1.2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                return AppCard(
                  title: snapshot.data!.docs[index]["disasterName"],
                  imageUrl: snapshot.data!.docs[index]["disasterImage"],
                  street:  snapshot.data!.docs[index]["address"],
                  date: formattedDate(snapshot.data!.docs[index]["date"]),
                  onTap: () {
                    if(globals.isAdmin) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDisaster(documentId: snapshot.data!.docs[index].id)));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDisasterUser(documentId: snapshot.data!.docs[index].id)));
                    }
                  },
                );
              }
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
