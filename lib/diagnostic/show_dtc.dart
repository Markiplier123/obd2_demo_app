import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_chan_doan/mode_obj_info.dart';

class ShowDTC extends StatefulWidget {
  const ShowDTC({super.key, required this.modeInfoDTC});

  final List<mode_obj_info> modeInfoDTC;

  @override
  _ReadDTCPageState createState() => _ReadDTCPageState();
}

class _ReadDTCPageState extends State<ShowDTC> {
  final databaseRef = FirebaseDatabase.instance.ref();
  List<String> dtcCode = List.filled(256, '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqtt.publish('{"mode":${widget.modeInfoDTC[0].mode}}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.modeInfoDTC[0].name}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
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
          StreamBuilder(
            stream: databaseRef
                .child('${widget.modeInfoDTC[0].firebase_name}/num')
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                widget.modeInfoDTC[0].value = snapshot.data!.snapshot.value;
                widget.modeInfoDTC[0].pri_stat_1 = widget.modeInfoDTC[0].value;
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                        child: Center(
                            child: Text(
                              'Number Of ${widget.modeInfoDTC[0].name}: ${widget.modeInfoDTC[0].pri_stat_1}', 
                              style: TextStyle(fontSize: 20),
                            ))),
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: widget.modeInfoDTC[0].pri_stat_1,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return StreamBuilder(
                          stream: databaseRef
                              .child(
                                  '${widget.modeInfoDTC[0].firebase_name}/${index + 1}')
                              .onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                !snapshot.hasError &&
                                snapshot.data!.snapshot.value != null) {
                              dtcCode[index] =
                                  snapshot.data!.snapshot.value.toString();
                              return Card(
                                  color: const Color.fromARGB(255, 190, 190, 190),
                                  child: ListTile(
                                    leading: const Icon(Icons.warning, color: Colors.yellow,),
                                    title: Text('${dtcCode[index]}', style: TextStyle(fontSize: 20)),
                                  ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.delete, size: 25, color: Colors.white),
              label: const Text('CLEAR DTC TROUBLE CODE',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onPressed: () {
                mqtt.publish('{"mode":4}');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20), // Adjusted padding
                  textStyle: TextStyle(fontSize: 20) // Corrected text size
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
