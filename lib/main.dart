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
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
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

  final _tag = 'lewy_official';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 125,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/rl9-tlo.jpg'),
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profilowe.jpg'),
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
                  TwitterBio(tag: _tag),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwitterBio extends StatelessWidget {
  const TwitterBio({super.key, required String tag}) : _tag = tag;

  final String _tag;

  static const TextStyle _textBoldWhite = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.grey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          Row(
            spacing: 6,
            children: [
              Text(
                'Rafonix Lewandowski',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Color.fromARGB(255, 32, 111, 229),
              ),
            ],
          ),
          Text('@$_tag'),
          Text('❤ | ❌ | 🙅‍♂️ | #rl9'),
          Row(
            spacing: 5,
            children: [
              Icon(Icons.calendar_month_outlined, color: Colors.grey),
              Text('Dołączył/a luty 2024  >'),
            ],
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(text: '53', style: _textBoldWhite),
                TextSpan(text: ' Obserwowani'),
                TextSpan(text: ' 2 866 159', style: _textBoldWhite),
                TextSpan(text: ' Obserwujący'),
              ],
            ),
          ),
        ],
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
        clicked ? 'Obserwujesz' : '   Obserwuj   ',
        style: GoogleFonts.roboto(
          color: clicked ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
