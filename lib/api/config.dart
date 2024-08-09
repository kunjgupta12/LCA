import 'package:flutter_dotenv/flutter_dotenv.dart';

final url = dotenv.env['BASE_URL'] ?? 'http://192.168.1.30:9002'; 

String  registration = url + "/api/v1/auth/register/customer"; 
final login = url + '/api/v1/auth/login';
final device_register = url + '/api/v1/devices/';
final devices = device_register + 'self';
final image_upload = url + "/api/v1/users/profile/image";
final complaint_regiaster=url+'/api/v1/complaint/register/customer';
final  apiUrl = 'http://api.weatherapi.com/v1/current.json';
final complaint_get =url+"/api/v1/complaint/self";
final complaint_count_api=url+"/api/v1/complaint/status/count/self";
final user_update=url+"/api/v1/users";
final get_device=url+'/api/v1/devices';
final schedule=url+'/api/v1/schedule/all/';