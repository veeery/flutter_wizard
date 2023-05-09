import 'dart:convert';

import 'package:flutter_wizard/common/constants.dart';
import 'package:flutter_wizard/common/exception.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_model.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_response.dart';
import 'package:http/http.dart' as http;

abstract class WizardRemoteDataSource {
  Future<List<WizardModel>> getWizard();
}

class WizardRemoteDataSourceImpl implements WizardRemoteDataSource {
  final http.Client client;

  WizardRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WizardModel>> getWizard() async {
    final response = await client.get(Uri.parse('$baseUrl/wizards'));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = {
        'results': jsonDecode(response.body),
        // todo add pagination here later
      };

      String data = json.encode(map);

      return WizardResponse.fromJson(json.decode(data)).wizardList;
    } else {
      throw ServerException();
    }
  }
}
