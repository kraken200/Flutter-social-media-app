import 'package:fitworld_app/screens/diet_screen.dart';
import 'package:fitworld_app/screens/goal_screen.dart';
import 'package:fitworld_app/screens/progress_screen.dart';
import 'package:fitworld_app/screens/training_tool_screen.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:fitworld_app/widgets/tool_card.dart';
import 'package:flutter/material.dart';
import 'package:fitworld_app/resources/auth_methods.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            title: Text(
              "Tools",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Progress())),
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.12),
                            spreadRadius: 5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Progress tracker",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TrainingTool())),
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.12),
                            spreadRadius: 5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Workout planner",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Diet_screen())),
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.12),
                            spreadRadius: 5,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Diet Tracker",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Goal_screen())),
                    child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.12),
                            spreadRadius: 5,
                            blurRadius: 11,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Goals",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
