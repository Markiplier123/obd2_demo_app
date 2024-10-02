import 'dart:async';
import 'dart:math' as math;
import 'package:app_chan_doan/mode_1/mode_1_second_page.dart';
import 'package:app_chan_doan/mode_obj_info.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color contentColorCyan = Color.fromARGB(255, 0, 130, 150);
  static const Color contentColorBlue = Color.fromARGB(255, 0, 80, 150);
}

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key, required this.chartValue});

  final mode_obj_info chartValue;

  @override
  State<ChartWidget> createState() {
    return _ChartWidgetState();
  }
}

class _ChartWidgetState extends State<ChartWidget> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  List<FlSpot> Points = []; // Danh sách điểm dữ liệu
  Timer? timer;
  int xValue = 0;
  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị ngẫu nhiên và cập nhật mỗi giây
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        currentValue = widget.chartValue.value; // Hàm cập nhật giá trị biến int
        Points.add(FlSpot(xValue.toDouble(), currentValue.toDouble()));
        xValue++;
        Points.removeWhere((point) => point.x < xValue - 100);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Points.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 20, left: 20, right: 20),
                    height: screenHeight * 0.9,
                    child: LineChart(mainChartData()))
                : CircularProgressIndicator(),
          ),
          Positioned(
            top: screenHeight * 0.45, // Adjusted dynamically
            left: screenWidth * -0.05, // Adjusted dynamically
            child: Transform.rotate(
              angle: -math.pi / 2,
              child: Text(
                '${widget.chartValue.name} (   )',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  // fontFamily: 'Times',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05, // Adjusted dynamically
            right: screenWidth * 0.4, // Adjusted dynamically
            child: const Text(
              'Times (ms)',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                // fontFamily: 'Times',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.88, // Adjusted dynamically
            right: screenWidth * 0.35, // Adjusted dynamically
            child: Text(
              '${widget.chartValue.name} Chart',
              style: const TextStyle(
                color: Color.fromARGB(255, 190, 123, 224),
                fontSize: 20,
                // fontFamily: 'Times',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Positioned(
          //   top: screenHeight * 0.05, // Adjusted dynamically
          //   left: screenWidth * 0.05, // Adjusted dynamically
          //   child: IconButton(
          //     icon: const Icon(Icons.arrow_back,
          //         size: 30, color: Colors.black),
          //     onPressed: () {
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => Mode1SecondPage(b: listMode1info)));
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  LineChartData mainChartData() {
    return LineChartData(
      minX: xValue > 100 ? xValue - 100 : 0,
      maxX: xValue > 100 ? xValue - 0 : 100,
      minY: 0,
      maxY: 6000,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color.fromARGB(
                255, 150, 150, 150), // Change to your desired color
            strokeWidth: 1.0,
            dashArray: [5, 3], // Set the thickness of the line
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color.fromARGB(
                255, 150, 150, 150), // Change to your desired color
            strokeWidth: 1.0,
            dashArray: [5, 3], // Set the thickness of the line
          );
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom:
              BorderSide(color: Color.fromARGB(255, 243, 242, 242), width: 4),
          left: BorderSide(color: Color.fromARGB(255, 242, 241, 241), width: 4),
          right: BorderSide(color: Color.fromARGB(0, 245, 244, 244)),
          top: BorderSide(color: Color.fromARGB(0, 237, 236, 236)),
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 100,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
            spots: Points,
            isCurved: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: false,
            ),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ))
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 1000:
        text = const Text(
          '1000',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            // fontFamily: 'Times',
          ),
        );
        break;
      case 3000:
        text = const Text(
          '3000',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            // fontFamily: 'Times',
          ),
        );
        break;
      case 5000:
        text = const Text(
          '5000',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            // fontFamily: 'Times',
          ),
        );
        break;
      default:
        text = const Text('');
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 15, // Default value
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int displayValue = (value + (xValue > 1500 ? xValue - 1500 : 0)).toInt();
    if (displayValue % 2 == 0) {
      return Text(
        '$displayValue',
        style: const TextStyle(
          color: Colors.black,
          // fontFamily: 'Times',
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      );
    }
    return const Text('');
  }
}
