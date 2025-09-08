import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([BankHttp])
class BankHttp {
  final http.Client client;

  BankHttp({http.Client? client}) : client = client ?? http.Client();

  Future<String> dolarToReal() async {
    var url = Uri.https('olinda.bcb.gov.br', '/last/USD-BRL');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String value = jsonResponse['USDBRL']['high'];
      return value;
    } else {
      print('Não foi possível se conectar com a API: ${response.statusCode}');
      return '?';
    }
  }
}
