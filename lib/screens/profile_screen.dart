

import 'package:flutter/material.dart';
import 'package:food/components/circle_image.dart';
import 'package:food/models/app_state_manager.dart';
import 'package:food/models/fooderlich_pages.dart';
import 'package:food/models/profile_manager.dart';
import 'package:food/models/user.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {

  static MaterialPage page(User user) {
    return MaterialPage(
      name: FooderlichPages.profilePath,
      key: ValueKey(FooderlichPages.profilePath),
      child: ProfileScreen(user: user),
    );
  }

  final User user;

  const ProfileScreen({Key? key,required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Provider.of<ProfileManager>(context, listen: false).tapOnProfile(false);
        }, icon: const Icon(Icons.close)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16,),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }


  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(fontSize: 21),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

 Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: const Text('View raywenderlich.com'),
          onTap: () {
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnRaywenderlich(true);
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // 1
            Provider.of<ProfileManager>(context, listen: false)
                .tapOnProfile(false);
            // 2
            Provider.of<AppStateManager>(context, listen: false).logOut();
          },
        )
      ],
    );
 }

 Widget buildDarkModeRow() {
   return Padding(
     padding: const EdgeInsets.all(16.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         const Text('Dark Mode'),
         Switch(
           value: widget.user.darkMode,
           onChanged: (value) {
             Provider.of<ProfileManager>(context, listen: false).darkMode=value;
           },
         )
       ],
     ),
   );
 }
}
