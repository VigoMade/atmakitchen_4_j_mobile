import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/view/item.dart';

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
        backgroundColor: const Color(0xFFAD343E),
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
            height: 190,
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 8.0,
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
              builder: (context) => ItemPage(
                title: item.title,
              ),
            ),
          );
        },
        child: SizedBox(
          width: 85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 75,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(198, 160, 180, 0.486),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  )),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 180,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFFAD343E), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
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
                    fit: BoxFit.cover,
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
