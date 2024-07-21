import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLightOn = false;
  bool _isFanOn = false;
  bool _isAcOn = false;
  bool _isHeaterOn = false;
  bool _isTvOn = false;

  double _currentWaterConsumption = 123.45;
  double _previousWaterConsumption = 100.0;
  double _currentGasConsumption = 78.9;
  double _previousGasConsumption = 85.0;
  String currentConsumption = "Current consumption";
  String prevConsumption = "Previous consumption";


  @override
  void initState() {
    super.initState();
    // Simulate real-time data
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/device_data.json');
      final data = jsonDecode(response);

      setState(() {
        final devices = data['devices'];

        _isLightOn = devices.firstWhere((device) => device['name'] == 'Light')['status'] == 'on';
        _isFanOn = devices.firstWhere((device) => device['name'] == 'Fan')['status'] == 'on';
        _isAcOn = devices.firstWhere((device) => device['name'] == 'Air Conditioner')['status'] == 'on';
        _isHeaterOn = devices.firstWhere((device) => device['name'] == 'Heater')['status'] == 'on';
        _isTvOn = devices.firstWhere((device) => device['name'] == 'TV')['status'] == 'on';

        final waterMeter = devices.firstWhere((device) => device['name'] == 'Water Meter');
        final gasMeter = devices.firstWhere((device) => device['name'] == 'Gas Meter');
        final latestWaterReading = waterMeter['readings'].last;
        final latestGasReading = gasMeter['readings'].last;

        _currentWaterConsumption = latestWaterReading['value'];
        _previousWaterConsumption = waterMeter['readings'].first['value'];
        _currentGasConsumption = latestGasReading['value'];
        _previousGasConsumption = gasMeter['readings'].first['value'];
      });
    } catch (e) {
      // Handle errors if necessary
      print('Error loading device data: $e');
    }
  }

  // void updateStateFromJson(Map<String, dynamic> jsonResponse) {
  //   setState(() {
  //     for (var device in jsonResponse['devices']) {
  //       switch (device['name']) {
  //         case 'Light':
  //           _isLightOn = device['status'] == 'on';
  //           break;
  //         case 'Fan':
  //           _isFanOn = device['status'] == 'on';
  //           break;
  //         case 'Air Conditioner':
  //           _isAcOn = device['status'] == 'on';
  //           break;
  //         case 'Heater':
  //           _isHeaterOn = device['status'] == 'on';
  //           break;
  //         case 'TV':
  //           _isTvOn = device['status'] == 'on';
  //           break;
  //         case 'Water Meter':
  //           _currentWaterConsumption = device['readings'][0]['value'];
  //           _previousWaterConsumption = device['readings'][1]['value'];
  //           break;
  //         case 'Gas Meter':
  //           _currentGasConsumption = device['readings'][0]['value'];
  //           _previousGasConsumption = device['readings'][1]['value'];
  //           break;
  //         default:
  //           break;
  //       }
  //     }
  //   });
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings'); // Navigate to the SettingsScreen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildConsumptionChart('Water Consumption', _currentWaterConsumption, _previousWaterConsumption),
                _buildConsumptionChart('Gas Consumption', _currentGasConsumption, _previousGasConsumption),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Light',
            icon: Icons.lightbulb_outline,
            value: _isLightOn,
            onChanged: (value) {
              setState(() {
                _isLightOn = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Fan',
            icon: Icons.toys,
            value: _isFanOn,
            onChanged: (value) {
              setState(() {
                _isFanOn = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Air Conditioner',
            icon: Icons.ac_unit,
            value: _isAcOn,
            onChanged: (value) {
              setState(() {
                _isAcOn = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Heater',
            icon: Icons.whatshot,
            value: _isHeaterOn,
            onChanged: (value) {
              setState(() {
                _isHeaterOn = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'TV',
            icon: Icons.tv,
            value: _isTvOn,
            onChanged: (value) {
              setState(() {
                _isTvOn = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConsumptionChart(String title, double currentConsumption, double previousConsumption) {
    final List<ChartData> chartData = [
      ChartData(title , _currentWaterConsumption, Colors.blue),
      ChartData(title , _previousWaterConsumption, Colors.green),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 185,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SfCircularChart( // Use SfCircularChart for radial chart
                  backgroundColor: Colors.transparent, // Optional for clarity

                  series: [
                    RadialBarSeries( // Use RadialBarSeries for radial segments
                      dataSource: chartData,
                      dataLabelSettings: const DataLabelSettings(isVisible: false), // Optional: hide data labels
                      cornerStyle: CornerStyle.bothCurve, // Set corner style for a curved look
                      maximumValue: currentConsumption + previousConsumption, // Adjust maximum value for better visualization
                      trackOpacity: 0.2,
                      animationDuration: 1000,
                      animationDelay: 150,
                      gap: '5%',
                      xValueMapper: (datum, int index) => datum.x,
                      yValueMapper: (datum, int index) => datum.y,
                      pointColorMapper: (datum , int index) => datum.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current: ${currentConsumption.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                'Previous: ${previousConsumption.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({required String title, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SwitchListTile(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          secondary: Icon(icon, color: Colors.white),
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey[700],
        ),
      ),
    );
  }
}



class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

