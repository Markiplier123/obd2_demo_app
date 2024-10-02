import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mode_4/mode_4_second_page.dart';

class Mode4FirstPage extends StatelessWidget {
  const Mode4FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actuators Test'),
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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: listMode4info.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            style: const ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              '${listMode4info[index].name}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Mode4SecondPage(Mode4ActInfo: listMode4info[index], streamDataMonitor: listMode1info,)));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
