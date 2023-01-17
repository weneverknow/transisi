import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:transisi/src/core/cubit/loading_cubit.dart';
import 'package:transisi/src/core/widgets/buttons/default_button.dart';
import 'package:transisi/src/core/widgets/dialog_widget.dart';
import 'package:transisi/src/core/widgets/image_network_wrapper.dart';
import 'package:transisi/src/core/widgets/inputs/text_input_field.dart';
import 'package:transisi/src/core/widgets/texts/title_text.dart';
import 'package:transisi/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:transisi/src/features/authentication/presentation/cubit/password_visibility_cubit.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.go('/');
        }
        if (state is AuthenticationFailed) {
          showErrorDialog(context, title: "Failed", message: state.message);
        }

        if (state is! AuthenticationInitial) {
          context.read<LoadingCubit>().update();
        }
      },
      child: BlocProvider(
        create: (context) => PasswordVisibilityCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              const SizedBox.expand(
                child: ImageNetworkWrapper(
                  height: double.infinity,
                  width: double.infinity,
                  imageUrl:
                      "https://c4.wallpaperflare.com/wallpaper/805/668/874/lofi-neon-coffee-house-shop-neon-glow-hd-wallpaper-preview.jpg",
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, minHeight: double.infinity),
                margin: const EdgeInsets.only(top: defaultPadding * 6),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      TitleText(
                        text: "PLEASE SIGN IN",
                        textAlign: TextAlign.center,
                      ).child,
                      _buildInput(
                          labelText: 'Email', controller: _emailController),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      BlocBuilder<PasswordVisibilityCubit, bool>(
                        builder: (context, state) {
                          return _buildInput(
                              labelText: 'Password',
                              controller: _passwordController,
                              obscureText: !state,
                              icon: Icons.lock,
                              suffixIcon: _buildVisibilityIcon(context, state));
                        },
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: BlocBuilder<LoadingCubit, bool>(
                          builder: (context, state) {
                            return DefaultButton(
                              text: state ? "PLEASE WAIT..." : "LOGIN",
                              onPressed: state
                                  ? null
                                  : () async {
                                      context.read<LoadingCubit>().update();
                                      context.read<AuthenticationBloc>().add(
                                          AuthenticationUserLogin(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text));
                                    },
                            ).child;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisibilityIcon(BuildContext context, bool state) {
    return GestureDetector(
        onTap: () {
          context.read<PasswordVisibilityCubit>().update();
        },
        child: state
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }

  Widget _buildInput({
    TextEditingController? controller,
    String? labelText,
    IconData? icon,
    bool? obscureText,
    Widget? suffixIcon,
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
