


import 'package:flutter/material.dart';
import 'package:food/api/mock_fooderlich_service.dart';
import 'package:food/components/recipes_grid_view.dart';
import 'package:food/models/simple_recipe.dart';

class RecipesScreen extends StatelessWidget {


  const RecipesScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final exploreService = MockFooderlichService();
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (BuildContext context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          return RecipesGridView(recipes: snapshot.data ?? []);
        }
        else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },

    );
  }
}
