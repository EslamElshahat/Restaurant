import 'package:flutter/material.dart';
import 'package:meal/dummy_data.dart';
import 'package:meal/modules/meal.dart';
import 'package:meal/widgets%20/meal_item.dart';
class CategoryMealScreen extends StatefulWidget {

  static const routeName = 'category_meal';

  CategoryMealScreen(List<Meal> availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {

   late  String categoryTitle;
  late List<Meal> displayMeals;


  @override
  void didChangeDependencies() {
    final routeArg = ModalRoute.of(context)?.settings?.arguments as Map<String,String>;
    final categoryId = routeArg['id'];
     categoryTitle = routeArg['title'].toString();
     displayMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  @override
  void initState() {


    super.initState();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle.toString())),
      body: ListView.builder(
          itemBuilder: (ctx,index){
            return MealItem(
              id: displayMeals[index].id,
              imageUrl: displayMeals[index].imageUrl,
              title: displayMeals[index].title,
              duration: displayMeals[index].duration,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
              // removeItem: _removeMeal,
                );
          },
          itemCount: displayMeals.length,
      ),
    );
  }
}
