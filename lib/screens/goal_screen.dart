import 'package:fitworld_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Goal_screen extends StatefulWidget {
  const Goal_screen({Key? key}) : super(key: key);

  @override
  State<Goal_screen> createState() => _Goal_screenState();
}

class _Goal_screenState extends State<Goal_screen> {
  final TextEditingController _presentcontroller = TextEditingController();
  final TextEditingController _futurecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Goals",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: mobileBackgroundColor,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 8,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _presentcontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Present weight',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _futurecontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Goal Weight',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _timecontroller,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        decoration: const InputDecoration(
                          labelText: 'Time Period',
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: Text(
                            "Calculate Goals",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
            )
          ],
        )));
    ;
  }
}
