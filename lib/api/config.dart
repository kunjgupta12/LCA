import 'package:flutter_dotenv/flutter_dotenv.dart';

final String url = dotenv.env['BASE_URL'] ?? 'http://192.168.1.30:9002'; 

// Auth endpoints
final String registration = '$url/api/v1/auth/register/customer';
final String login = '$url/api/v1/auth/login';

// Device-related endpoints
final String deviceRegister = '$url/api/v1/devices/';
final String devices = '${deviceRegister}self';
final String getDevice = '$url/api/v1/devices';
// User-related endpoints
final String imageUpload = '$url/api/v1/users/profile/image';
final String userUpdate = '$url/api/v1/users';

// Complaint-related endpoints
final String complaintRegister = '$url/api/v1/complaint/register/customer';
final String complaintGet = '$url/api/v1/complaint/self';
final String complaintCountApi = '$url/api/v1/complaint/status/count/self';

// Other endpoints
 String apiUrl = 'http://api.weatherapi.com/v1/current.json';
final String schedule = '$url/api/v1/schedule/all/';
