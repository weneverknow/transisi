import 'package:transisi/src/core/validator/string_validator.dart';

class EmployeeValidation {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? website;
  EmployeeValidation({this.website, this.firstName, this.lastName, this.email});

  StringValidator firstNameValidator = NonEmptyStrinValidation();
  StringValidator lastNameValidator = NonEmptyStrinValidation();
  StringValidator emailValidator = EmailFormatValidation();
  StringValidator websiteValidator = WebsiteValidation();

  bool get isFirstNameValid => firstNameValidator.isValid(firstName ?? "");
  bool get isLastNameValid => lastNameValidator.isValid(lastName ?? "");
  bool get isEmailValid =>
      (email ?? "").isEmpty ? true : emailValidator.isValid(email!);
  bool get isWebsiteValid =>
      (website ?? "").isEmpty ? true : websiteValidator.isValid(website!);
}
