import 'package:app_chan_doan/connection_manage.dart';
import 'package:app_chan_doan/mode_1/mode_1_chart.dart';
import 'package:app_chan_doan/mode_1/mode_1_first_page.dart';
import 'package:app_chan_doan/mode_4/mode_4_first_page.dart';
import 'package:app_chan_doan/mode_4/mode_4_livedata.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:flutter/material.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:firebase_database/firebase_database.dart';

List<String> status = ['Hoàn thành', 'Đang xử lý'];

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
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: const Color.fromARGB(255, 145, 220, 255),
          leading: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {
              if (didPop) {
                return;
              }
              mqtt.publish('{"mode":0}');
              streamDataMonitor.forEach((item) {
                item.status = false;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Mode4FirstPage()));
            },
            child: BackButton(
              color: Colors.black,
              onPressed: () {
                mqtt.publish('{"mode":0}');
                streamDataMonitor.forEach((item) {
                  item.status = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mode4FirstPage()));
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
          children: [
            SizedBox(width: 20),
            Row(
              children: [
                SizedBox(width: 18),
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 20, 50, 220)),
                ),
                Spacer(),
                Container(
                  child: StreamBuilder(
                    stream: databaseRef
                        .child('${verifyId}${Mode4ActInfo.firebase_name}')
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data!.snapshot.value != null) {
                        Mode4ActInfo.value = snapshot.data!.snapshot.value;
                        return Text(
                          '${status[((Mode4ActInfo.value + 255) / 256).toInt()]}',
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 20, 50, 220)),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
            SizedBox(width: 20),
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
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${temp[index].name}'),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: databaseRef
                                        .child(
                                            '${verifyId}${temp[index].firebase_name}')
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        temp[index].value =
                                            snapshot.data!.snapshot.value;
                                        return Text(
                                          '${temp[index].value}',
                                          style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 10, 90, 160)),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  Text('${temp[index].unit}',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChartWidget(
                                          chartValue: temp[index]))),
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
                    child: Text('Thông số'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish(
                          '{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":${Mode4ActInfo.pri_stat_2}}');
                    },
                    child: Text('Ngắt'),
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
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: const Color.fromARGB(255, 145, 220, 255),
          leading: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) {
              if (didPop) {
                return;
              }
              mqtt.publish('{"mode":0}');
              streamDataMonitor.forEach((item) {
                item.status = false;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Mode4FirstPage()));
            },
            child: BackButton(
              color: Colors.black,
              onPressed: () {
                mqtt.publish('{"mode":0}');
                streamDataMonitor.forEach((item) {
                  item.status = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mode4FirstPage()));
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
          children: [
            SizedBox(width: 20),
            Row(
              children: [
                SizedBox(width: 18),
                const Text(
                  'Trạng thái:',
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 20, 50, 220)),
                ),
                Spacer(),
                Container(
                  child: StreamBuilder(
                    stream: databaseRef
                        .child('${verifyId}${Mode4ActInfo.firebase_name}')
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data!.snapshot.value != null) {
                        Mode4ActInfo.value = snapshot.data!.snapshot.value;
                        return Text(
                          '${status[((Mode4ActInfo.value + 255) / 256).toInt()]}',
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 20, 50, 220)),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(width: 18),
              ],
            ),
            SizedBox(width: 20),
            Divider(),
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
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${temp[index].name}'),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: databaseRef
                                        .child(
                                            '${verifyId}${temp[index].firebase_name}')
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        temp[index].value =
                                            snapshot.data!.snapshot.value;
                                        return Text(
                                          '${temp[index].value}',
                                          style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 10, 90, 160)),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  Text('${temp[index].unit}',
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChartWidget(
                                          chartValue: temp[index]))),
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
                    child: Text('Thông số'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish(
                          '{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":1}');
                    },
                    child: Text('Bật'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      mqtt.publish(
                          '{"mode":${Mode4ActInfo.mode},"value":${Mode4ActInfo.pri_stat_1},"key":0}');
                    },
                    child: Text('Tắt'),
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
