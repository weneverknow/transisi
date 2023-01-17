import '/src/features/employee/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    int? id,
    String? firstName,
    String? lastName,
    String? job,
    String? email,
    String? phone,
    String? website,
    String? avatar,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          job: job,
          email: email,
          phone: phone,
          website: website,
          avatar: avatar,
        );

  Employee toEntities() => Employee(
        id: id,
        firstName: firstName,
        lastName: lastName,
        job: job,
        email: email,
        phone: phone,
        website: website,
        avatar: avatar,
      );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      id: int.tryParse("${json['id']}"),
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      job: json['job'],
      phone: json['phone'],
      website: json['website'],
      avatar: json["avatar"]);
}
