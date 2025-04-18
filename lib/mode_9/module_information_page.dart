import 'package:app_chan_doan/connection_manage.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:app_chan_doan/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rebi_vin_decoder/rebi_vin_decoder.dart';

class ModuleInformationPage extends StatelessWidget {
  const ModuleInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseRef = FirebaseDatabase.instance.ref();
    mqtt.publish('{"mode":9}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Đọc số VIN'),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listMode9info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${listMode9info[index].name}: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  StreamBuilder(
                    stream: databaseRef
                        .child(
                            '${verifyId}${listMode9info[index].firebase_name}')
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data!.snapshot.value != null) {
                        listMode9info[index].value =
                            snapshot.data!.snapshot.value;
                        return Text(
                          '${listMode9info[index].value}',
                          style: TextStyle(fontSize: 18),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                child: Text('Giải mã số VIN'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var vin = VIN(
                          number: '${listMode9info[index].value}',
                          extended: true);
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text('WMI: ${vin.wmi}'),
                                    Text('VDS: ${vin.vds}'),
                                    Text('VIS: ${vin.vis}'),
                                    Text("Mẫu: " + vin.modelYear()),
                                    Text("Số se-ri: " + vin.serialNumber()),
                                    Text("Nhà máy lắp ráp: " + vin.assemblyPlant()),
                                    Text("Nhà sản xuất: " + vin.getManufacturer().toString()),
                                    Text("Năm sản xuất: " + vin.getYear().toString()),
                                    Text("Khu vực: " + vin.getRegion()),
                                    Text("Chuỗi số VIN: " + vin.toString()),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Đóng'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
