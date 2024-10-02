import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Mode6Page extends StatelessWidget {
  const Mode6Page({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance.ref();
    mqtt.publish('{"mode":6}');

    return Scaffold(
      appBar: AppBar(
        title: Text('OBD Test Results'),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const <int, TableColumnWidth> {
                0: FlexColumnWidth(),
                1: FixedColumnWidth(85),
                2: FixedColumnWidth(85),
                3: FixedColumnWidth(85),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: const [
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Min', style: TextStyle(fontWeight: FontWeight.bold))))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Test Value', style: TextStyle(fontWeight: FontWeight.bold))))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Max', style: TextStyle(fontWeight: FontWeight.bold))))),
                  ],
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listMode6info.length,
              itemBuilder: (context, index) {
                return Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const <int, TableColumnWidth> {
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(85),
                    2: FixedColumnWidth(85),
                    3: FixedColumnWidth(85),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(listMode6info[index].name))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: StreamBuilder(
                            stream: databaseRef
                                .child('${listMode6info[index].firebase_name}/min')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                listMode6info[index].value = snapshot.data!.snapshot.value;
                                return Center(
                                  child: Text(
                                    '${listMode6info[index].value}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),)),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: StreamBuilder(
                            stream: databaseRef
                                .child('${listMode6info[index].firebase_name}/test_value')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                listMode6info[index].value = snapshot.data!.snapshot.value;
                                return Center(
                                  child: Text(
                                    '${listMode6info[index].value}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),)),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: StreamBuilder(
                            stream: databaseRef
                                .child('${listMode6info[index].firebase_name}/max')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                listMode6info[index].value = snapshot.data!.snapshot.value;
                                return Center(
                                  child: Text(
                                    '${listMode6info[index].value}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),)),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
