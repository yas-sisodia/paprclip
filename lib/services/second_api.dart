import 'dart:convert';

import 'package:http/http.dart';


class SecondApiService{
  static Future<List<dynamic>> getRequest()async{
    Response response = await get(Uri.parse('https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en'));
    List<dynamic> data = jsonDecode(response.body);
    // print(data);
    return data;
  }
}