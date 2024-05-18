import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Booking Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
