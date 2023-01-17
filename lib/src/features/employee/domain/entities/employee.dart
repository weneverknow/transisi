import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? job;
  final String? email;
  final String? phone;
  final String? website;
  final String? avatar;

  const Employee({
    this.id,
    this.firstName,
    this.lastName,
    this.job,
    this.email,
    this.phone,
    this.website,
    this.avatar,
  });

  String get fullName => "$firstName $lastName";

  Map<String, dynamic> toJson() => avatar == null
      ? {
          "first_name": firstName,
          "last_name": lastName,
          "job": job,
          "email": email,
          "phone": phone,
          "website": website,
        }
      : {
          "avatar": avatar,
          "first_name": firstName,
          "last_name": lastName,
          "job": job,
          "email": email,
          "phone": phone,
          "website": website,
        };

  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? job,
    String? email,
    String? phone,
    String? website,
    String? avatar,
  }) =>
      Employee(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        job: job ?? this.job,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        avatar: avatar ?? this.avatar,
      );
  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        job,
        email,
        phone,
        website,
        avatar,
      ];
}
