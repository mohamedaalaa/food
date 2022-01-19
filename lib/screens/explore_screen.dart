

import 'package:flutter/material.dart';
import 'package:food/api/mock_fooderlich_service.dart';
import 'package:food/components/friend_post_list_view.dart';
import 'package:food/components/today_recipe_list_view.dart';
import 'package:food/models/explore_data.dart';

class ExploreScreen  extends StatelessWidget {

  ExploreScreen();

  @override
  Widget build(BuildContext context) {
    final mookService=MockFooderlichService();
    return FutureBuilder(
      future: mookService.getExploreData(),
      builder: (BuildContext context, AsyncSnapshot<ExploreData> snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          return ListView(scrollDirection: Axis.vertical, children: [
            TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
            const SizedBox(height: 16),
            FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? [])
          ]);
        }else{
          return const Center(child: CircularProgressIndicator());
        }

      },

    );
  }


}
