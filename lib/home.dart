

import 'package:flutter/material.dart';
import 'package:food/models/profile_manager.dart';
import 'package:food/models/tab_manager.dart';
import 'package:food/screens/explore_screen.dart';
import 'package:food/screens/grrocery_screen.dart';
import 'package:food/screens/recipe_screen.dart';
import 'package:provider/provider.dart';

import 'models/app_state_manager.dart';
import 'models/fooderlich_pages.dart';

class Home extends StatefulWidget {

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: FooderlichPages.home,
      key: ValueKey(FooderlichPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab; //Home({required this.title});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<Widget> pages=[
    ExploreScreen(),
    const RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (BuildContext context, appStateManager,  child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Fooderlich',style: Theme.of(context).textTheme.headline6,),
            actions: [
              profileButton(),
            ],
          ),
          body: IndexedStack(
            index:widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:Theme.of(context).textSelectionTheme.selectionColor ,
            currentIndex: widget.currentTab,
            onTap: (index){
              Provider.of<AppStateManager>(context,listen: false).goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
            ],
          ),
        );
      },

    );
  }


  Widget profileButton(){
    return Padding(
      padding:const  EdgeInsets.only(right: 16),
          child: GestureDetector(
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/profile_pics/person_stef.jpeg',
              ),
            ),
            onTap: (){
              Provider.of<ProfileManager>(context,listen: false).tapOnProfile(true);
            },
          ),
    );
  }
}
