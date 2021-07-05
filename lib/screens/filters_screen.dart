import 'package:flutter/material.dart';
import 'package:meal/widgets%20/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters ,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _glutenFree = false;
  late bool _lactoseFree = false;
  late bool _vegan = false;
  late bool _vegetarian = false;

  Map filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegan': false,
    'vegetarian': false
  };

  @override
  initState(){
     _glutenFree = widget.currentFilters['gluten']!;
     _lactoseFree = widget.currentFilters['lactose']!;
     _vegan = widget.currentFilters['vegan']!;
     _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String description, String filterId) {
    return SwitchListTile(
        title: Text(title),
        value: filters[filterId],
        subtitle: Text(description),
        onChanged: (newValue) {
          setState(() {
            filters[filterId] = newValue;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(onPressed: (){
            final Map<String,bool> selectedFilters = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilters);},
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust Your Meal Selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              buildSwitchListTile('Gluten-Free',
                  "Only include gluten-free meals", 'glutenFree'),
              buildSwitchListTile('Lactose-Free',
                  "Only include lactoseFree meals", 'lactoseFree'),
              buildSwitchListTile(
                'Vegetarian',
                "Only include Vegetarian meals",
                'vegetarian',
              ),
              buildSwitchListTile(
                'Vegan',
                "Only include Vegan meals",
                'vegan',
              ),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
    ;
  }
}
