import 'package:flutter/material.dart';
import 'package:uno_mas_uno/presentation/ui/pages/organization_page.dart';
import 'package:uno_mas_uno/presentation/ui/pages/people_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> pages = [PeoplePage(), OrganizationPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1MAS1'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Equipo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree), label: "Organización")
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
      ),
    );
  }
}
