import 'dart:convert';

import 'package:transisi/src/core/connection/remote_service.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:transisi/src/core/exceptions/exceptions.dart';
import 'package:transisi/src/features/employee/data/model/employee_model.dart';

abstract class EmployeeDatasource {
  Future<List<EmployeeModel>> fetch();
  Future<EmployeeModel> create({
    String? firstName,
    String? lastName,
    String? job,
    String? email,
    String? phone,
    String? website,
  });
  Future<EmployeeModel> update(int id, Map<String, dynamic> body);
}

class EmployeeDatasourceImpl implements EmployeeDatasource {
  final RemoteService remoteService;
  EmployeeDatasourceImpl(this.remoteService);
  @override
  Future<List<EmployeeModel>> fetch() async {
    final response = await remoteService.get("$apiurl/users?page=1");

    if (response.statusCode != 200) {
      throw DataNotFoundException("users not found");
    }
    var items = jsonDecode(response.body)['data'] as List;
    return items.map((e) => EmployeeModel.fromJson(e)).toList();
  }

  @override
  Future<EmployeeModel> create({
    String? firstName,
    String? lastName,
    String? job,
    String? email,
    String? phone,
    String? website,
  }) async {
    var body = {
      "first_name": firstName,
      "last_name": lastName,
      "job": job,
      "email": email,
      "phone": phone,
      "website": website,
    };
    final response = await remoteService.post(
      "$apiurl/users",
      body: body,
    );
    if (response.statusCode != 201) {
      throw HttpErrorException("User didn't created successfully");
    }
    var data = jsonDecode(response.body);

    return EmployeeModel.fromJson(data);
  }

  @override
  Future<EmployeeModel> update(int id, Map<String, dynamic> body) async {
    final response = await remoteService.put("$apiurl/users/$id", body: body);
    if (response.statusCode != 200) {
      throw HttpErrorException("User didn't created successfully");
    }
    var data = jsonDecode(response.body);
    data['id'] = id;

    return EmployeeModel.fromJson(data);
  }
}
