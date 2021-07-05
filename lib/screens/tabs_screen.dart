import 'package:flutter/material.dart';
import 'package:meal/modules/meal.dart';
import 'package:meal/screens/favorite_screen.dart';
import 'package:meal/widgets%20/main_drawer.dart';
import 'categories_screen.dart';

class TabsScreen extends StatefulWidget {

  final List <Meal> favoriteMeals;

  const TabsScreen({ required this.favoriteMeals});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  late List<Map<String, StatelessWidget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page' : CategoriesScreen(),
        'title': Text('categories')
      },
      {
        'page' : FavoriteScreen(widget.favoriteMeals),
        'title': Text('Your Favorites')
      }
    ];
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_selectedPageIndex]['title'],
      ),
      body:  _pages[_selectedPageIndex]['page'],
      // body: Text(_pages[_selectedPageIndex]['title'].toString()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites"),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
