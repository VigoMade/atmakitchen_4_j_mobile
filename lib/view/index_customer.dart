import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/view/eksplore.dart';
import 'package:atmakitchen_4_j_mobile/view/booking.dart';
import 'package:atmakitchen_4_j_mobile/profile.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int _selectedIndex = 0; // Inisialisasi indeks default

  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    BookingPage(), // Mengubah presensiView() menjadi PresensiView()
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex; // Atur nilai indeks dengan nilai dari properti widget
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0), // Padding from edges
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(20.0), // Rounded corners for clipping
            child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 8.0,
              backgroundColor: Color.fromARGB(255, 245, 248, 255),
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color for selected label
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color for unselected label
              ),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.explore,
                    size: 24,
                  ),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bed,
                    size: 24,
                  ),
                  label: 'Booking',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24,
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 231, 80, 80),
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
              selectedFontSize:
                  14, // Slightly larger font size for selected item
              unselectedFontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
