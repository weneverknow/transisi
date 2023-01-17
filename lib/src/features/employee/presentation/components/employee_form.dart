import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/cubit/loading_cubit.dart';
import '../../../../core/messages/messages.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/inputs/text_input_field.dart';
import '../../domain/entities/employee_validation.dart';
import '../cubit/employee_validation_cubit.dart';

class EmployeeForm extends StatelessWidget {
  EmployeeForm({this.em, super.key});
  final Employee? em;

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _jobController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _websiteController = TextEditingController();

  setData() {
    if (em != null) {
      //var em = .em;
      _firstNameController.text = em?.firstName ?? "";
      _lastNameController.text = em?.lastName ?? "";
      _jobController.text = em?.job ?? "";
      _emailController.text = em?.email ?? "";
      _phoneController.text = em?.phone ?? "";
      _websiteController.text = em?.website ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return ListView(
      children: [
        BlocBuilder<EmployeeValidationCubit, EmployeeValidation?>(
          builder: (context, state) {
            return _buildInput(
              labelText: "First Name",
              controller: _firstNameController,
              icon: Icons.person,
              errorText: state != null
                  ? (state.isFirstNameValid ? null : errorFirstNameEmpty)
                  : null,
            );
          },
        ),
        BlocBuilder<EmployeeValidationCubit, EmployeeValidation?>(
          builder: (context, state) {
            return _buildInput(
                labelText: "Last Name",
                controller: _lastNameController,
                icon: Icons.person,
                errorText: state != null
                    ? (state.isLastNameValid ? null : errorLastNameEmpty)
                    : null);
          },
        ),
        _buildInput(
          labelText: "Job",
          controller: _jobController,
          icon: Icons.work_history,
        ),
        BlocBuilder<EmployeeValidationCubit, EmployeeValidation?>(
          builder: (context, state) {
            return _buildInput(
              labelText: "Email",
              controller: _emailController,
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
              errorText: state != null
                  ? (state.isEmailValid ? null : errorEmailFormat)
                  : null,
            );
          },
        ),
        _buildInput(
          labelText: "Phone",
          controller: _phoneController,
          icon: Icons.phone,
          inputType: TextInputType.phone,
        ),
        BlocBuilder<EmployeeValidationCubit, EmployeeValidation?>(
          builder: (context, state) {
            return _buildInput(
                labelText: "Website",
                controller: _websiteController,
                icon: Icons.web,
                inputType: TextInputType.url,
                errorText: state != null
                    ? (state.isWebsiteValid ? null : errorWebsiteFormat)
                    : null);
          },
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: BlocBuilder<LoadingCubit, bool>(
            builder: (context, state) {
              return DefaultButton(
                      text: state ? "PLEASE WAIT..." : "CREATE CONTACT",
                      onPressed: state
                          ? null
                          : () async {
                              context.read<EmployeeValidationCubit>().validate(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    website: _websiteController.text,
                                  );
                            })
                  .child;
            },
          ),
        )
      ],
    );
  }

  Widget _buildInput({
    TextEditingController? controller,
    String? labelText,
    IconData? icon,
    bool? obscureText,
    Widget? suffixIcon,
    String? errorText,
    TextInputType? inputType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.email),
          const SizedBox(
            width: defaultPadding / 2,
          ),
          Flexible(
              child: TextInputField(
                      inputType: inputType,
                      errorText: errorText,
                      suffixIcon: suffixIcon,
                      obscureText: obscureText,
                      controller: controller,
                      labelText: '$labelText')
                  .child)
        ],
      ),
    );
  }
}
