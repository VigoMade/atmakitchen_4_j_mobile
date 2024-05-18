import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.produk}) : super(key: key);
  final Produk produk;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Atma Kitchen",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFAD343E),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
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
                          '${ApiClient().domainName}/images/${widget.produk.image}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, url, error) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                                () {}); // Memicu pembaruan UI untuk mencoba memuat gambar lagi
                          },
                          child: Container(
                            color: Colors.grey,
                            child: Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        );
                      },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                widget.produk.namaProduk,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                'Rp ${widget.produk.hargaProduk.toString()}.00',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 8.0),
                          child: Text(
                            "Stock : ${widget.produk.stockProduk.toString()}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                          child: Text(
                            "Kue lapis legit merupakan makanan khas Lampung yang terkenal. Kue yang bertekstur lembut dan bercita rasa manis ini biasa dijadikan cemilan santai ketika dirumah. Kue lapis legit juga sering disajikan pada acara hajatan.",
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
      ),
    );
  }
}
