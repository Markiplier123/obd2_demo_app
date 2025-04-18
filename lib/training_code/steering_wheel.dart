import 'package:app_chan_doan/connection_manage.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class SteeringWheel extends StatefulWidget {
  @override
  State<SteeringWheel> createState() {
    return _SteeringWheelState();
  }
}

class _SteeringWheelState extends State<SteeringWheel> {
  final _angleRef = FirebaseDatabase.instance.ref('${verifyId}/61/STA');
  double _currentAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    mqtt.publish('{"mode":33}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Góc quay vô lăng'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        leading: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            mqtt.publish('{"mode":0}');
            Navigator.of(context).pop();
          },
          child: BackButton(
            color: Colors.black,
            onPressed: () {
              mqtt.publish('{"mode":0}');
              Navigator.of(context).pop();
            },
          ),
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
                _currentAngle = (-angleInDegrees) * pi / 180;
                return Column(
                  children: [
                    Center(
                      child: Card(
                        color: Color.fromARGB(255, 100, 180, 246),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '${(angleInDegrees)} (Độ)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: _currentAngle),
                      duration: Duration(milliseconds: 200),
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
