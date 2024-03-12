import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/home/components/home_form.dart';
import 'package:flutter_app/responsive.dart';
import '../../components/background.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Background(
  child: SingleChildScrollView(
    child: Responsive(
      mobile: MobileHomeScreen(),
      desktop: Row(
        children: [
         
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 450,
                  child: homeForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
}

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    
    Row(
      children: [
        Spacer(),
        Expanded(
          flex: 8,
          child: homeForm(),
        ),
        Spacer(),
      ],
    ),
  ],
);

  }
} 
