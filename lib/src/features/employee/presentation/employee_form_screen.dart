import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transisi/src/core/cubit/loading_cubit.dart';
import 'package:transisi/src/core/widgets/default_app_bar.dart';
import 'package:transisi/src/core/widgets/dialog_widget.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/domain/entities/employee_validation.dart';
import 'package:transisi/src/features/employee/presentation/bloc/employee_list_bloc.dart';
import 'package:transisi/src/features/employee/presentation/cubit/employee_validation_cubit.dart';
import 'package:transisi/src/features/employee/presentation/cubit/manage_employee_cubit.dart';
import 'package:transisi/src/service_locator.dart';

import '../../../core/constants/constants.dart';
import '../../../core/messages/messages.dart';
import '../../../core/widgets/buttons/default_button.dart';
import '../../../core/widgets/inputs/text_input_field.dart';
import '../domain/usecase/create_employee_usecase.dart';
import '../domain/usecase/update_employee_usecase.dart';

class EmployeeFormScreen extends StatelessWidget {
  EmployeeFormScreen({
    this.id,
    super.key,
  });
  final int? id;

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _jobController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _websiteController = TextEditingController();

  setData({
    Employee? em,
  }) {
    if (em != null) {
      _firstNameController.text = em.firstName ?? "";
      _lastNameController.text = em.lastName ?? "";
      _jobController.text = em.job ?? "";
      _emailController.text = em.email ?? "";
      _phoneController.text = em.phone ?? "";
      _websiteController.text = em.website ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Employee? em;
    if (id != null) {
      em = context.select<EmployeeListBloc, Employee?>((bloc) =>
          (bloc.state as EmployeeListLoadSuccess)
              .items
              .firstWhere((element) => element.id == id));
      setData(em: em);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ManageEmployeeCubit(
                sl<CreateEmployeeUsecase>(), sl<UpdateEmployeeUsecase>())),
        BlocProvider(create: (_) => EmployeeValidationCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ManageEmployeeCubit, Employee?>(
            listener: (context, state) {
              if (state == null) {
                showErrorDialog(context,
                    title: "Failed", message: "Create employee failed");
              }
              if (state != null) {
                Fluttertoast.showToast(
                  msg: id == null
                      ? "Employee created successfully"
                      : "Employee updated successfully",
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );

                context.read<EmployeeListBloc>().add(EmployeeListInsert(state));

                Navigator.of(context).pop();
              }
              context.read<LoadingCubit>().update();
            },
          ),
          BlocListener<EmployeeValidationCubit, EmployeeValidation?>(
            listener: (context, state) {
              if (state != null) {
                if (state.isFirstNameValid &&
                    state.isLastNameValid &&
                    state.isEmailValid &&
                    state.isWebsiteValid) {
                  context.read<LoadingCubit>().update();
                  if (id == null) {
                    context.read<ManageEmployeeCubit>().create(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          job: _jobController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          website: _websiteController.text,
                        );
                  } else {
                    context.read<ManageEmployeeCubit>().update(em!.copyWith(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          job: _jobController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          website: _websiteController.text,
                        ));
                  }
                }
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: DefaultAppBar(label: "Employee Form").appBar,
          body: ListView(
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
                            text: state
                                ? "PLEASE WAIT..."
                                : id == null
                                    ? "CREATE EMPLOYEE"
                                    : "UPDATE EMPLOYEE",
                            onPressed: state
                                ? null
                                : () async {
                                    context
                                        .read<EmployeeValidationCubit>()
                                        .validate(
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
          ),
        ),
      ),
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
