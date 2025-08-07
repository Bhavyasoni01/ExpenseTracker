import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(child: 
      CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Settings"),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 219, 214, 214).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(22),
              ),
              

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Text('Dark mode',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400

                        ),),
                        
                      ),
                      SizedBox(width: 120,),
                      ToggleSwitch(
                        minWidth: 40.0,
                    minHeight: 40.0,
                    initialLabelIndex: 0,
                    cornerRadius: 10.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    icons: [
                      FontAwesomeIcons.lightbulb,
                      FontAwesomeIcons.solidLightbulb,
                    ],
                    iconSize: 30.0,
                    activeBgColors: [[Colors.black45, Colors.black26], [Colors.yellow, Colors.                  orange]],
                    animate: true, // with just animate set to true, default curve = Curves.easeIn
                   curve: Curves.bounceInOut, // animate must be set to true when using custom curve
                    onToggle: (index) {
          print('switched to: $index');
        },
                      )
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        )
      ],        
      )),
    );
  }
}