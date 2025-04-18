import 'package:app_chan_doan/mode_4/mode_4_second_page.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';

class ListCheck extends StatefulWidget {
  const ListCheck(
      {super.key, required this.checkboxValue, required this.mode4Info});

  final List<mode_obj_info> checkboxValue;
  final mode_obj_info mode4Info;

  @override
  State<ListCheck> createState() {
    return _ListCheckState();
  }
}

class _ListCheckState extends State<ListCheck> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: widget.checkboxValue.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.white,
          child: CheckboxListTile(
            title: Text('${widget.checkboxValue[index].name}'),
            value: widget.checkboxValue[index].status,
            onChanged: (bool? value) {
              setState(() {
                widget.checkboxValue[index].status = value!;
              });
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class Mode4Livedata extends StatefulWidget {
  const Mode4Livedata(
      {super.key, required this.mode4Info, required this.checkboxValue});

  final mode_obj_info mode4Info;
  final List<mode_obj_info> checkboxValue;

  @override
  State<StatefulWidget> createState() {
    return _Mode4LivedataState();
  }
}

class _Mode4LivedataState extends State<Mode4Livedata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.mode4Info.name}'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        leading: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            Navigator.of(context).pop();
          },
          child: BackButton(
            color: Colors.black,
            onPressed: () {
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListCheck(
              checkboxValue: widget.checkboxValue,
              mode4Info: widget.mode4Info,
            ),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.checkboxValue.forEach((item) {
                        item.status = true;
                      });
                    });
                  },
                  child: Text('Chọn tất cả'),
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
                      widget.checkboxValue.forEach((item) {
                        item.status = false;
                      });
                    });
                  },
                  child: Text('Hủy tất cả'),
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
                    widget.checkboxValue.forEach((item) {
                      if (item.status) {
                        value |= (1 << item.pri_stat_1);
                      }
                    });
                    mqtt.publish('{"mode":1,"value":$value}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Mode4SecondPage(
                                Mode4ActInfo: widget.mode4Info,
                                streamDataMonitor: widget.checkboxValue)));
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
