import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[400],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: const Text('TO DO APP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60.0,
                            fontFamily: 'RussoOne'
                          )),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          'Team 8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'RussoOne'
                          ),
                        )),
                  ]),
            ),
            Expanded(
                child: MaterialButton(
              elevation: 0,
              color: Colors.white,
              shape: CircleBorder(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const HomePage())));
              },
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.blue,
                size: 36,
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
