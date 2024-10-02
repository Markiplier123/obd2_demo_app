import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ModuleInformationPage extends StatelessWidget {
  const ModuleInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance.ref();
    mqtt.publish('{"mode":9}');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Module Information'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listMode9info.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text('${listMode9info[index].name}: ', style: TextStyle(fontSize: 20),),
              StreamBuilder(
                stream: databaseRef
                    .child('${listMode9info[index].firebase_name}')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data!.snapshot.value != null) {
                    listMode9info[index].value = snapshot.data!.snapshot.value;
                    return Text(
                      '${listMode9info[index].value}',
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
