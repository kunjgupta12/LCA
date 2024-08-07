import 'package:flutter/material.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/device/device.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:get/get.dart';

class Devices {
  final DeviceService _deviceService = DeviceService();

  Future<void> registerDevice(
    String imei,
    String title,
    String latitude,
    String longitude,
    bool expansionMode,
    String token,
    String country,
    String pincode,
    String state,
    String fullAddress,
    String valveCount,
    String city,BuildContext context
  ) async {
    var regBody = _createRequestBody(
      imei, title, latitude, longitude, expansionMode, country, pincode, state, fullAddress, valveCount, city
    );

    await _deviceService.registerDevice(regBody, token,context);
  }

  Future<void> updateDevice(
    String id,
    String imei,
    String title,
    String latitude,
    String longitude,
    bool expansionMode,
    String token,
    String country,
    String pincode,
    String state,
    String fullAddress,
    String valveCount,
    String city,BuildContext context

  ) async {
    var regBody = _createRequestBody(
      imei, title, latitude, longitude, expansionMode, country, pincode, state, fullAddress, valveCount, city
    );

    await _deviceService.updateDevice(id, regBody, token,context);
  }

  Future<void> deleteDevice(String id,BuildContext context
) async {
    await _deviceService.deleteDevice(id,context);
  }

  Future<Device> fetchDevice(int id) async {
    return await _deviceService.fetchDevice(id);
  }

  Map<String, dynamic> _createRequestBody(
    String imei,
    String title,
    String latitude,
    String longitude,
    bool expansionMode,
    String country,
    String pincode,
    String state,
    String fullAddress,
    String valveCount,
    String city,
  ) {
    return {
      "imei": imei,
      "title": title,
      "expansionMode": expansionMode,
      "valveCount": valveCount,
      "address": {
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
        "fullAdddress": fullAddress,
        "lat": latitude,
        "long": longitude,
      }
    };
  }
}
