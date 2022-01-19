import 'package:flutter/material.dart';
import 'package:food/models/app_state_manager.dart';
import 'package:food/models/fooderlich_pages.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page(){
    return MaterialPage(
      name:FooderlichPages.splashPath,
        key:ValueKey(FooderlichPages.splashPath),
        child: const SplashScreen());
  }


  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
