
import 'package:flutter_wizard/common/constants.dart';
import 'package:flutter_wizard/common/exception.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_model.dart';
import 'package:flutter_wizard/data/models/wizard/wizard_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class WizardRemoteDataSource {
  Future<List<WizardModel>> getWizard();
}

class WizardRemoteDataSourceImpl implements WizardRemoteDataSource {
  final http.Client client;

  WizardRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WizardModel>> getWizard() async {
    final response = await client.get(Uri.parse('$baseUrl/wizard'));

    if (response.statusCode == 200) {
      return WizardResponse.fromjson(json.decode(response.body)).wizardList;

      // return WizardModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
