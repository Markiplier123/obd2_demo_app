import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class SteeringWheel extends StatefulWidget {
  @override
  _SteeringWheelState createState() => _SteeringWheelState();
}

class _SteeringWheelState extends State<SteeringWheel> {
  final _angleRef = FirebaseDatabase.instance.ref('2000/61/STA');
  double _currentAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    mqtt.publish('{"mode":33}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Training code'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            mqtt.publish('{"mode":0}');
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: _angleRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                double angleInDegrees =
                    double.parse(snapshot.data!.snapshot.value.toString());
                _currentAngle = angleInDegrees * pi / 180;
                return Column(
                  children: [
                    Center(
                      child: Container(
                        color: Colors.lightBlue,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '$angleInDegrees',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: _currentAngle),
                      duration: Duration(seconds: 1),
                      builder: (context, angle, child) {
                        return Transform.rotate(
                          angle: angle,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/steering_wheel.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
