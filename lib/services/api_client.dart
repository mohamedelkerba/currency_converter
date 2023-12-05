import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyURL = Uri.parse("https://api.frankfurter.app/latest?");

  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var rates = body["rates"];

      if (rates != null && rates is Map) {
        List<String> currencies = rates.keys.cast<String>().toList();
        // print(currencies);
        return currencies;
      } else {
        throw Exception("Invalid response format: rates not found or not a Map");
      }
    } else {
      throw Exception("Failed to connect to the API. Status code: ${res.statusCode}");
    }
  }



  Future<Map<String, dynamic>> getRate(String from, String to) async {
    final Uri rateUrl = Uri.parse(
        "https://api.frankfurter.app/latest?&from=$from&to=$to"
    );

    http.Response res = await http.get(rateUrl);
    // print('////res${res.body.toString()}');

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      // Assuming the API response has a structure like {"from&to": rate}
      return body["rates"];
    } else {
      throw Exception("Failed to connect to the API");
    }
  }
}





//compact=ultra
//https://api.currencyfreaks.com/v2.0/rates/latest?apikey=bcc8fbc8b40d44ab92f1977894f4bf2a