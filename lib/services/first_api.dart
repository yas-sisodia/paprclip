import 'dart:convert';

import 'package:http/http.dart';

class FirstApiService {
  static Future<Map<String, dynamic>> getRequest() async {
    Response response = await get(Uri.parse(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en'));
    Map<String, dynamic> data = jsonDecode(response.body);
    // print(data);
    return data;
  }
}
