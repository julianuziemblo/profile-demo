import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lewandowski',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // TODO:
        // textTheme: TextTheme(),
        // colorScheme: ...
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Image.asset('rl9-tlo.jpg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('profilowe.jpg'),
                    radius: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clicked = !clicked;
                      });
                    },
                    child: FollowButton(clicked: clicked),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({super.key, required this.clicked});

  final bool clicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: clicked ? Colors.black : Colors.white,
        border: Border.all(width: 4, color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
      child: Text(
        'Obserwuj',
        style: GoogleFonts.roboto(
          color: clicked ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
