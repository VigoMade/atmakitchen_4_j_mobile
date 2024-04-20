import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/item.dart';

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
  @override
  Widget build(BuildContext context) {
    List<CardItem> items = [
      const CardItem(image: "images/cake.png", title: "Cake", subTitle: ""),
      const CardItem(image: "images/bread.png", title: "Roti", subTitle: ""),
      const CardItem(
          image: "images/minuman.png", title: "Minuman", subTitle: ""),
      const CardItem(
          image: "images/hampers.png", title: "Hampers", subTitle: ""),
      const CardItem(
          image: "images/lainnya.png", title: "Lainnya", subTitle: ""),
    ];

    List<CardItem> menu = [
      const CardItem(
          image: "images/milk_bun.jpg",
          title: "Milk Bun",
          subTitle: "Rp 130.000,00"),
      const CardItem(
          image: "images/keripik_kentang.jpg",
          title: "Keripik Kentang",
          subTitle: "Rp 100.000,00"),
      const CardItem(
          image: "images/lapis_surabaya.jpg",
          title: "Lapis Surabaya",
          subTitle: "Rp 120.000,00"),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, _) => const SizedBox(
                width: 12,
              ),
              itemBuilder: (context, index) => buildCard(item: items[index]),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Special Menu",
              style: TextStyle(fontSize: 30), // Mengatur teks ke tengah
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom dalam grid
                crossAxisSpacing: 9.0, // Jarak antara kolom
                mainAxisSpacing: 8.0, // Jarak antara baris
              ),
              itemCount: menu.length,
              itemBuilder: (context, index) => buildCardMenu(item: menu[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required CardItem item}) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => itemPage(
                title: item.title,
              ),
            ),
          );
        },
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(198, 160, 180, 0.486),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(item.image)),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );

  Widget buildCardMenu({required CardItem item}) => GestureDetector(
        onTap: () {
          _showItemDetails(item);
        },
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFFAD343E), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit
                        .cover, // Sesuaikan gambar dengan ukuran kontainer
                  ),
                ),
              ),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );

  void _showItemDetails(CardItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit
                        .cover, // Sesuaikan gambar dengan ukuran kontainer
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(item.subTitle),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
