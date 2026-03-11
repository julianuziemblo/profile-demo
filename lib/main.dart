import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:profile/cubit/dark_mode_cubit.dart';
import 'package:profile/post.dart';
import 'package:profile/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  final key = dotenv.env['MAPBOX_API_KEY'];
  if (key == null) {
    return;
  }
  MapboxOptions.setAccessToken(key);
  runApp(const MyApp());
}

Future<geo.Position> _determinePosition() async {
  bool serviceEnabled;
  geo.LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await geo.Geolocator.checkPermission();
  if (permission == geo.LocationPermission.denied) {
    permission = await geo.Geolocator.requestPermission();
    if (permission == geo.LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == geo.LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await geo.Geolocator.getCurrentPosition();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DarkModeCubit(),
      child: MaterialApp(
        title: 'Lewandowski',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
        home: const MyHomePage(),
      ),
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

  static const _tag = 'lewy_official';
  static const _profileName = 'Rafonix Lewandowski';

  List<Widget> getPosts(int n) {
    return List.generate(
      n,
      (i) => TwitterPost(
        id: i,
        profileName: _profileName,
        date: DateTime.now(),
        tag: _tag,
        text: '$i',
      ),
    );
  }

  late final MapboxMap mapController;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<DarkModeCubit>().state;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final position = await _determinePosition();
          mapController.location.updateSettings(
            LocationComponentSettings(enabled: true),
          );
          mapController.flyTo(
            CameraOptions(
              center: Point(
                coordinates: Position(position.longitude, position.latitude),
              ),
              zoom: 15,
            ),
            MapAnimationOptions(duration: 1500),
          );
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: MapWidget(
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
      //  Container(
      //   color: state is DarkModeOn ? Colors.black : Colors.white,
      //   child: ListView(
      //     children: [
      //       Container(
      //         height: 125,
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: AssetImage('assets/rl9-tlo.jpg'),
      //             fit: BoxFit.fitWidth,
      //             alignment: FractionalOffset.center,
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(15),
      //         child: Column(
      //           spacing: 10,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 CircleAvatar(
      //                   backgroundImage: AssetImage('assets/profilowe.jpg'),
      //                   radius: 40,
      //                 ),
      //                 GestureDetector(
      //                   onTap: () {
      //                     setState(() {
      //                       clicked = !clicked;
      //                     });
      //                   },
      //                   child: FollowButton(clicked: clicked),
      //                 ),
      //               ],
      //             ),
      //             TwitterBio(profileName: _profileName, tag: _tag),
      //             ...getPosts(10),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class TwitterBio extends StatelessWidget {
  const TwitterBio({super.key, required String tag, required this.profileName})
    : _tag = tag;

  final String profileName;
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
                profileName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                overflow: TextOverflow.ellipsis,
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
