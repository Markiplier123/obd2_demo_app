import 'package:app_chan_doan/mode_1/mode_1_chart.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Checked extends StatelessWidget {
  const Checked({super.key, required this.checkedValue});

  final List<mode_obj_info> checkedValue;

  @override
  Widget build(BuildContext context) {
    List<mode_obj_info> temp = List.from(checkedValue.where((element) => element.status));
    final databaseRef = FirebaseDatabase.instance.ref();

    return ListView.separated(
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
                  stream:
                      databaseRef.child('${temp[index].firebase_name}').onValue,
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
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChartWidget(chartValue: temp[index]))),
                  icon: Icon(Icons.add_chart)
                )
              ],
            ),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}