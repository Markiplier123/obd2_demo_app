import 'package:app_chan_doan/mode_1/mode_1_chart.dart';
import 'package:app_chan_doan/mode_1/mode_1_first_page.dart';
import 'package:app_chan_doan/mode_4/mode_4_livedata.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:flutter/material.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:firebase_database/firebase_database.dart';

List<String> status = ['Completed', 'In Progress'];

class Mode4SecondPage extends StatelessWidget {
  const Mode4SecondPage(
      {super.key, required this.Mode4ActInfo, required this.streamDataMonitor});

  final mode_obj_info Mode4ActInfo;
  final List<mode_obj_info> streamDataMonitor;

  @override
  Widget build(BuildContext context) {
    List<mode_obj_info> temp =
        List.from(streamDataMonitor.where((element) => element.status));
    final databaseRef = FirebaseDatabase.instance.ref();
    if (Mode4ActInfo.pri_stat_1 == 0x10) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${Mode4ActInfo.name}'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          backgroundColor: const Color.fromARGB(255, 145, 220, 255),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              mqtt.publish('{"mode":0}');
              streamDataMonitor.forEach((item) {
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
            Container(
              child: StreamBuilder(
                stream:
                    databaseRef.child('${Mode4ActInfo.firebase_name}').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data!.snapshot.value != null) {
                    Mode4ActInfo.value = snapshot.data!.snapshot.value;
                    return Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          '${Mode4ActInfo.name}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          '${status[((Mode4ActInfo.value + 255) / 256).toInt()]}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: temp.length,
                itemBuilder: (BuildContext context, int index) {
                  if (temp[index].status) {
                    return Container(
                      child: Row(
                        children: [
                          Text('${temp[index].name}'),
                          Spacer(),
                          StreamBuilder(
                            stream: databaseRef
                                .child('${temp[index].firebase_name}')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                temp[index].value = snapshot.data!.snapshot.value;
                                return Text(
                                  '${temp[index].value}',
                                  style: TextStyle(fontSize: 20),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChartWidget(chartValue: temp[index]))),
                              icon: Icon(Icons.add_chart))
                        ],
                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mode4Livedata(
                                mode4Info: Mode4ActInfo,
                                checkboxValue: streamDataMonitor))),
                    child: Text('Monitor'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish('{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":${Mode4ActInfo.pri_stat_2}}');
                    },
                    child: Text('Perform'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('${Mode4ActInfo.name}'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          backgroundColor: const Color.fromARGB(255, 145, 220, 255),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              mqtt.publish('{"mode":0}');
              streamDataMonitor.forEach((item) {
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
            Container(
              child: StreamBuilder(
                stream:
                    databaseRef.child('${Mode4ActInfo.firebase_name}').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data!.snapshot.value != null) {
                    Mode4ActInfo.value = snapshot.data!.snapshot.value;
                    return Row(
                      children: [
                        Text(
                          '${Mode4ActInfo.name}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          '${status[((Mode4ActInfo.value + 255) / 256).toInt()]}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: temp.length,
                itemBuilder: (BuildContext context, int index) {
                  if (temp[index].status) {
                    return Container(
                      child: Row(
                        children: [
                          Text('${temp[index].name}'),
                          Spacer(),
                          StreamBuilder(
                            stream: databaseRef
                                .child('${temp[index].firebase_name}')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                temp[index].value = snapshot.data!.snapshot.value;
                                return Text(
                                  '${temp[index].value}',
                                  style: TextStyle(fontSize: 20),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChartWidget(chartValue: temp[index]))),
                              icon: Icon(Icons.add_chart))
                        ],
                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mode4Livedata(
                                mode4Info: Mode4ActInfo,
                                checkboxValue: streamDataMonitor))),
                    child: Text('Monitor'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish('{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":1}');
                    },
                    child: Text('On'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish('{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":0}');
                    },
                    child: Text('Off'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
