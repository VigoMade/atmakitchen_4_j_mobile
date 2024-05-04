import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/produk_data.dart'; // Tambahkan import ini

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(); // Ubah menjadi final
    return FutureBuilder<List<Produk>>(
      future: ProdukClient(apiClient)
          .getProdukList(), // Perbaiki cara membuat instance ProdukClient
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
                  // your app bar code
                  ),
              body: Column(
                children: [
                  // your search container code
                  // your alignment container code
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return buildCardMenu(produk: produk);
                      },
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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 170,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFFAD343E), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    getThumbnail(produk
                        .image!), // Use the image URL from the Produk object
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      produk.namaProduk,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(produk.hargaProduk.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
