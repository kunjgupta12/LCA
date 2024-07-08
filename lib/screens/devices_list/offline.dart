import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/device.dart';

class DeviceListScreen extends StatefulWidget {
  String? data;
  DeviceListScreen({super.key, required this.data});
  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> jsonData = jsonDecode(widget.data.toString());
    final List<Device> devices =
        jsonData.map((data) => Device.fromJson(data)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Data'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return ListTile(
            title: Text(device.toString()),
            subtitle: Text('IMEI: ${device}\nCreated On: ${device}'),
            trailing: Text('ID: ${device}'),
          );
        },
      ),
    );
  }
}
