import 'package:app_chan_doan/diagnostic/show_dtc.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:flutter/material.dart';

class DiagnosticPage extends StatelessWidget {
  const DiagnosticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 220, 255),
        title: const Text('Diagnostic'),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: <Widget>[
          _buildButton(context, "Stored DTC",
              'assets/images/Stored_DTC.png', ShowDTC(modeInfoDTC: listMode3info)),
          _buildButton(context, "Pending DTC",
              'assets/images/Pending_DTC.png', ShowDTC(modeInfoDTC: listMode7info)),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, String iconPath, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 3), // White border around the button
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        backgroundColor: Colors.white, // Background color black
        foregroundColor: Colors.black, // Text color white
        elevation: 0, // Optional: adds shadow to the button
        shadowColor: Colors.black.withOpacity(1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 183, 183, 183).withOpacity(0),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(iconPath,
                width: 60,
                height: 60), // Image adjusted to not use ColorFiltered
          ),
          SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}