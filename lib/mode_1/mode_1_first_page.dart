import 'package:app_chan_doan/mode_1/mode_1_second_page.dart';
import 'package:flutter/material.dart';
import 'package:app_chan_doan/mode_1/mode_1_list_check.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';

class Mode1FirstPage extends StatefulWidget {
  const Mode1FirstPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Mode1FirstPageState();
  }
}

class _Mode1FirstPageState extends State<Mode1FirstPage> {
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
            listMode1info.forEach((item) {
              item.status = false;
            });
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
        children: [
          Expanded(
            child: ListCheck(
              checkboxValue: listMode1info,
            ),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      listMode1info.forEach((item) {
                        item.status = true;
                      });
                    });
                  },
                  child: Text('Select All'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      listMode1info.forEach((item) {
                        item.status = false;
                      });
                    });
                  },
                  child: Text('Clear All'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    int value = 0;
                    listMode1info.forEach((item) {
                      if (item.status) {
                        value |= (1 << item.pri_stat_1);
                      }
                    });
                    mqtt.publish('{"mode":1,"value":$value}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Mode1SecondPage(b: listMode1info)));
                  },
                  child: Text('OK'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
