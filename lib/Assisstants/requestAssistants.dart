import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistants {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = json.decode(jsonData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (error) {
      return "failed.";
    }
  }
}
