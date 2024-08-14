
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/complaint/complaint_issue.dart';
import 'package:lca/screens/devices_list/device_scroll.dart';
import 'package:http/http.dart' as http;
class IssueProvider with ChangeNotifier {
  List<Issue> _issues = [];
  bool _isLoading = false;
  String? _errorMessage = '';

  List<Issue> get devices => _issues;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  IssueProvider() {
    fetchissues(token.toString());
  }
  Future<void> fetchissues(String token) async {
     _isLoading = true;
    notifyListeners();
    final String apiUrl = '$url/api/v1/category/';
   _errorMessage = null;
    final Uri uri = Uri.parse(apiUrl);
  try {
      final response = await http.get(
        uri,
        headers:await getHeaders()
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Issue data: ${data}');

        List jsonResponse = json.decode(response.body);
        _issues = jsonResponse.map((job) => Issue.fromJson(job)).toList();
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load devices';
      }
    } catch (e) {
      _errorMessage = 'Failed to load devices: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}