import 'package:app_chan_doan/mode_1/mode_1_checked.dart';
import 'package:app_chan_doan/mode_1/mode_1_first_page.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';

class Mode1SecondPage extends StatelessWidget {
  const Mode1SecondPage({super.key, required this.b});

  final List<mode_obj_info> b;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Data Stream'),
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
      body: Container(
        child: Checked(checkedValue: b),
      ),
    );
  }
}
