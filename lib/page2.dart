import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class Page2 extends StatelessWidget {
  Page2({super.key});

  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('kelembaban');

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, dd MMMM yyyy');
    String tanggalFormatted = formatter.format(now);

    var formatter2 = DateFormat('HH:mm');
    String waktuFormatted = formatter2.format(now);

    return Stack(
      children: [
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 600,
                decoration: BoxDecoration(
                  color: const Color(0xFF802520),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(100, 50),
                    bottomRight: Radius.elliptical(100, 50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white10.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 5,
                      blurStyle: BlurStyle.normal,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 175,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.water_outlined,
                        size: 200,
                        color: Color(0xFFF5EDDC),
                      ),
                      StreamBuilder(
                        stream: _database.onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              !snapshot.hasError &&
                              snapshot.data?.snapshot.value != null) {
                            var kelembaban =
                                (snapshot.data!.snapshot.value as num)
                                    .toDouble();
                            return Text.rich(
                              TextSpan(
                                text: kelembaban.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 75,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jost',
                                  color: Color(0xFFF5EDDC),
                                ),
                                children: const [
                                  TextSpan(text: '%'),
                                ],
                              ),
                            );
                          } else {
                            return const Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost',
                                color: Color(0xFFF5EDDC),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tanggalFormatted,
                            style: const TextStyle(
                              color: Color(0xFFF5EDDC),
                              fontFamily: 'Jost',
                            ),
                          ),
                          const Text(
                            ' | ',
                            style: TextStyle(
                              color: Color(0xFFF5EDDC),
                              fontFamily: 'Jost',
                            ),
                          ),
                          Text(
                            waktuFormatted,
                            style: const TextStyle(
                              color: Color(0xFFF5EDDC),
                              fontFamily: 'Jost',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Text(
                    '1101210293',
                    style: TextStyle(
                      color: Color(0xFFF5EDDC),
                      fontSize: 36,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Row(
            children: [
              Container(
                height: 10,
                width: 131,
                color: const Color(0xFFBA8530),
              ),
              Container(
                height: 10,
                width: 131,
                color: const Color(0xFF802520),
              ),
              Container(
                height: 10,
                width: 131,
                color: const Color(0xFF5C7F71),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
