import 'package:atmakitchen_4_j_mobile/view/detail_item.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/produk_data.dart';
import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late Future<List<Produk>> _produkFuture;

  @override
  void initState() {
    super.initState();
    _fetchProdukData();
  }

  void _fetchProdukData() {
    final apiClient = ApiClient();
    _produkFuture = ProdukClient(apiClient).getProdukList(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Produk>>(
      future: _produkFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Produk>? produkList = snapshot.data;
          if (produkList != null) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                ),
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
                backgroundColor: const Color(0xFFAD343E),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  // your search container code
                  // your alignment container code
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: produkList.length,
                        itemBuilder: (context, index) {
                          final produk = produkList[index];
                          return buildCardMenu(produk: produk);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No Data Available'));
          }
        }
      },
    );
  }

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
                  DetailPage(produk: produk),
            ),
          );
        },
        child: Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        '${ApiClient().domainName}/storage/${produk.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorWidget: (context, url, error) => Container(
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
      );
}
