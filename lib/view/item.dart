import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    List<CardItem> relatedItems = [];
    if (title == "Cake") {
      relatedItems = [
        const CardItem(
            image: "images/cake/brownies.png",
            title: "Brownies",
            subTitle: "Rp 150.000,00"),
        const CardItem(
            image: "images/cake/lapis_legit.png",
            title: "Lapis Legit",
            subTitle: "Rp 120.000,00"),
        const CardItem(
            image: "images/cake/lapis_surabaya.jpg",
            title: "Lapis Surabaya",
            subTitle: "Rp 180.000,00"),
        const CardItem(
            image: "images/cake/spikoe.png",
            title: "Spikoe",
            subTitle: "Rp 180.000,00"),
      ];
    } else if (title == "Roti") {
      relatedItems = [
        const CardItem(
            image: "images/roti/cheese_bread.png",
            title: "Cheese Bread",
            subTitle: "Rp 20.000,00"),
        const CardItem(
            image: "images/roti/milk_bun.jpg",
            title: "Milk Bun",
            subTitle: "Rp 15.000,00"),
        const CardItem(
            image: "images/roti/sosis.png",
            title: "Roti Sosis",
            subTitle: "Rp 25.000,00"),
      ];
    } else if (title == "Minuman") {
      relatedItems = [
        const CardItem(
            image: "images/minuman/choco.png",
            title: "Choco Creamy Latte",
            subTitle: "Rp 5.000,00"),
        const CardItem(
            image: "images/minuman/matcha.png",
            title: "Matcha Creamy Latte",
            subTitle: "Rp 7.000,00"),
      ];
    } else if (title == "Hampers") {
      relatedItems = [
        const CardItem(
            image: "images/hampers/paket_a.png",
            title: "Hampers A",
            subTitle: "Rp 250.000,00"),
        const CardItem(
            image: "images/hampers/paket_b.png",
            title: "Hampers B",
            subTitle: "Rp 300.000,00"),
        const CardItem(
            image: "images/hampers/paket_c.png",
            title: "Hampers C",
            subTitle: "Rp 200.000,00"),
      ];
    }
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFFAD343E),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(222, 217, 217, 0.699)),
                  fillColor: const Color(0xFFAD343E)),
              onChanged: (value) {},
              style: const TextStyle(
                  color: Color.fromARGB(255, 234, 227, 227), fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: relatedItems.length,
              itemBuilder: (context, index) =>
                  buildCardMenu(item: relatedItems[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardMenu({required CardItem item}) => GestureDetector(
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
                  child: Image.asset(
                    item.image,
                    fit: BoxFit
                        .cover, // Sesuaikan gambar dengan ukuran kontainer
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(item.subTitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

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
