import 'package:atmakitchen_4_j_mobile/model/hampers.dart';
import 'package:atmakitchen_4_j_mobile/view/hampersView.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/view/produkView.dart';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/produk_data.dart';
import 'package:atmakitchen_4_j_mobile/view/detail_item.dart';
import 'package:flutter/widgets.dart';

class CardItem {
  final String image;
  final String title;
  final String subTitle;

  const CardItem({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<Produk>> _produkFuture;

  @override
  void initState() {
    super.initState();
    _produkFuture = _fetchProdukData();
  }

  Future<List<Produk>> _fetchProdukData() async {
    final apiClient = ApiClient();
    return ProdukClient(apiClient).getProdukSpecial();
  }

  @override
  Widget build(BuildContext context) {
    List<CardItem> items = [
      const CardItem(image: "images/cake.png", title: "Cake", subTitle: ""),
      const CardItem(image: "images/bread.png", title: "Bread", subTitle: ""),
      const CardItem(image: "images/minuman.png", title: "Drink", subTitle: ""),
      const CardItem(
          image: "images/hampers.png", title: "Hampers", subTitle: ""),
      const CardItem(image: "images/lainnya.png", title: "Other", subTitle: ""),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/logo.png"),
        title: const Text(
          "Atma Kitchen",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 40,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 201, 52, 64),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10),
            child: const Text(
              "Category",
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, _) => const SizedBox(
                width: 5,
              ),
              itemBuilder: (context, index) => buildCard(item: items[index]),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Special Menu",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: FutureBuilder<List<Produk>>(
                future: _produkFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No special products available'));
                  } else {
                    final produkList = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0, // Increased spacing
                        mainAxisSpacing: 16.0, // Increased spacing
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return buildCardMenu(produk: produk);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required CardItem item}) => GestureDetector(
        onTap: () {
          item.title == "Hampers"
              ? Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HampersPage(),
                  ),
                )
              : Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ItemPage(
                      title: item.title,
                    ),
                  ),
                );
        },
        child: Card(
          margin: EdgeInsets.only(top: 20, right: 5, left: 5),
          elevation: 5.0,
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(121, 238, 195, 121),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildCardMenu({required Produk produk}) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DetailPage(
                produk: produk,
              ),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 250, // Menetapkan tinggi minimum pada Container
              maxHeight: 300, // Menetapkan tinggi maksimum pada Container
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14.0),
                    ),
                    child: Image.network(
                      '${ApiClient().domainName}/images/${produk.image}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150, // Menetapkan tinggi pada Image
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey,
                        child: Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            produk.namaProduk,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Rp ${produk.hargaProduk.toString()}.00',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
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
