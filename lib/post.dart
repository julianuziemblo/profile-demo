import 'package:flutter/material.dart';

class TwitterPost extends StatelessWidget {
  const TwitterPost({
    super.key,
    required this.id,
    required this.profileName,
    required this.tag,
    required this.date,
    required this.text,
  });

  final int id;
  final String tag;
  final String profileName;
  final DateTime date;
  final String text;

  static const double _profileDataSize = 15;

  // dart format off
  static const _monthsAbbr = [ 
    'Sty', 'Lut', 'Mar', 
    'Kwi', 'Maj', 'Cze', 
    'Lip', 'Sie', 'Wrz', 
    'Paź', 'Lis', 'Gru',
  ];
  // dart format on

  String _formatDate(DateTime date) {
    return '${'${date.day}'.padLeft(2, '0')} ${_monthsAbbr[date.month]}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/profilowe.jpg'),
            radius: _profileDataSize,
          ),
        ),
        Expanded(
          flex: 20,
          child: Column(
            children: [
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: _profileDataSize,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 6,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        Text(
                          profileName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: _profileDataSize,
                          color: Color.fromARGB(255, 32, 111, 229),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('@$tag'),
                          Text('•'),
                          Text(_formatDate(date)),
                          Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: _profileDataSize,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(text, style: TextStyle(color: Colors.grey)),
              ),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(30)),
                child: Image.network(
                  'https://ocdn.eu/sport-images-transforms/1/zxhk9lBaHR0cHM6Ly9vY2RuLmV1L3B1bHNjbXMvTURBXy9kZWQ4MGI4MzBjNDIwMzhkMjM1ZTdiMmY5YzFjODgzMC5qcGeTlQPNAT8azQUozQLmlQLNBLAAwsOTCaZjYmVhNjIG3gACoTABoTEB/robert-lewandowski.jpg',
                  errorBuilder: (context, error, stackTrace) =>
                      // opcja 1
                      Text(
                        'nie udalo się załadować obrazka :( powód: $error',
                        style: TextStyle(color: Colors.red),
                      ),
                  // opcja 2
                  // Image.asset('assets/profilowe.jpg'),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress?.cumulativeBytesLoaded ==
                          loadingProgress?.expectedTotalBytes
                      ? child
                      : CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
