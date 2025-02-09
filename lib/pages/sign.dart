import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neushub/pages/app_bar.dart';

import 'package:neushub/bloc/sign_bloc.dart';

import '../theme.dart';
import '../widgets.dart';
import '../main.dart';

class NeusHubSignDialog extends Dialog {
  const NeusHubSignDialog({super.key});

  NeusHubSignType signType(NeusHubSignPageState state) {
    if (state is NeusHubSignPageChangedState) {
      return state.signType;
    } else {
      return NeusHubSignType.signIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: BlocProvider<NeusHubSignPageBloc>(
        create: (context) => NeusHubSignPageBloc(),
        child: BlocBuilder<NeusHubSignPageBloc, NeusHubSignPageState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.5,
                    horizontal:
                        (MediaQuery.sizeOf(context).width < mobileSize.width)
                            ? 15
                            : 50,
                  ),
                  decoration: BoxDecoration(
                    border: Theme.of(context).appBarTheme.shape as Border,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeusHubAppBarTitle(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      switch (signType(state)) {
                        NeusHubSignType.signUp => Row(
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              NeusHubTextIconButton(
                                icon: Icons.abc,
                                label: 'Log in?',
                                activated: true,
                                only: NeusHubTextIconOnly.textOnly,
                                onPressed: () {
                                  BlocProvider.of<NeusHubSignPageBloc>(context)
                                      .add(
                                    NeusHubSignChangePageEvent(
                                      NeusHubSignType.signIn,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        _ => Row(
                            children: [
                              Text(
                                'Don\'t have account? ',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              NeusHubTextIconButton(
                                icon: Icons.abc,
                                label: 'Apply now',
                                activated: true,
                                only: NeusHubTextIconOnly.textOnly,
                                onPressed: () {
                                  BlocProvider.of<NeusHubSignPageBloc>(context)
                                      .add(
                                    NeusHubSignChangePageEvent(
                                      NeusHubSignType.signUp,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                      },
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: (MediaQuery.sizeOf(context).width <
                            mobileSize.width + 100)
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: (MediaQuery.sizeOf(context).width <
                                mobileSize.width + 100)
                            ? MediaQuery.sizeOf(context).width - 40
                            : 425,
                        height: 500,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'Welcome to '),
                                    TextSpan(
                                      text: 'Neus',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    TextSpan(text: 'Hub'),
                                  ],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: 'With '),
                                    TextSpan(
                                      text: 'NausHub',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' dashboard you can track analytics of how your newsletter doing in our platform.',
                                    ),
                                  ],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              switch (signType(state)) {
                                NeusHubSignType.signUp => NeusHubSignUpPage(),
                                _ => NeusHubSignInPage(),
                              },
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !(MediaQuery.sizeOf(context).width <
                            mobileSize.width + 100),
                        child: SizedBox(
                          width: 400,
                          child: Image.asset('assets/images/sign.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NeusHubSignInPage extends StatefulWidget {
  const NeusHubSignInPage({
    super.key,
  });

  @override
  State<NeusHubSignInPage> createState() => _NeusHubSignInPageState();
}

class _NeusHubSignInPageState extends State<NeusHubSignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailController, passworrdContoller;

  @override
  void initState() {
    emailController = TextEditingController();
    passworrdContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passworrdContoller.dispose();
    super.dispose();
  }

  bool remember = false, valid = false;
  String response = '';

  void signValidate(
    String email,
    String password, [
    bool remember = false,
  ]) async {
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password)) {
      dynamic r = await nodeAPI.signIn(
        email,
        password,
        '',
        remember,
      );
      setState(() {
        valid = true;
        response = (r == 'password not match' || r == 'user not found')
            ? r as String
            : '';
        if (response == '') {
          rootKey.currentState?.refresh();
          Navigator.of(context).pop();
        }
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.email,
            contrroller: emailController,
          ),
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.password,
            contrroller: passworrdContoller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: remember,
                        activeColor: NeusHubColors.transparent,
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              NeusHubTextIconButton(
                icon: Icons.abc,
                label: 'Forgot Password?',
                only: NeusHubTextIconOnly.textOnly,
                textDecoration: TextDecoration.underline,
              ),
            ],
          ),
          SizedBox(height: 5),
          NeusHubTextIconButton.filled(
            icon: Icons.abc,
            label: 'Sign in',
            only: NeusHubTextIconOnly.textOnly,
            expanded: true,
            activated: true,
            onPressed: () {
              signValidate(
                emailController.text,
                passworrdContoller.text,
                remember,
              );
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            child: (response == '')
                ? null
                : Text(
                    response,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class NeusHubSignUpPage extends StatefulWidget {
  const NeusHubSignUpPage({
    super.key,
  });

  @override
  State<NeusHubSignUpPage> createState() => _NeusHubSignUpPageState();
}

class _NeusHubSignUpPageState extends State<NeusHubSignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController emailController,
      passworrdContoller,
      confirmPasswordController,
      nameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passworrdContoller = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passworrdContoller.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool valid = false;
  String response = '';

  void signValidate(
    String email,
    String password,
    String confirmPassword,
    String name,
  ) async {
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(password) &&
        RegExp(r'^[a-zA-Z\s]+$').hasMatch(name) &&
        password == confirmPassword) {
      dynamic r = await nodeAPI.signUp(
        email,
        name,
        password,
      );
      setState(() {
        valid = true;
        response = (r.toString() == 'true') ? '' : 'user exist';
        if (response == '') {
          rootKey.currentState?.refresh();
          Navigator.of(context).pop();
        }
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.name,
            contrroller: nameController,
          ),
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.email,
            contrroller: emailController,
          ),
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.password,
            contrroller: passworrdContoller,
          ),
          NeusHubTextIconField.filled(
            formKey: formKey,
            fieldType: NeusHubTextIconFieldType.confirmPassword,
            contrroller: confirmPasswordController,
          ),
          SizedBox(height: 5),
          NeusHubTextIconButton.filled(
            icon: Icons.abc,
            label: 'Sign up',
            only: NeusHubTextIconOnly.textOnly,
            expanded: true,
            activated: true,
            onPressed: () {
              signValidate(
                emailController.text,
                passworrdContoller.text,
                confirmPasswordController.text,
                nameController.text,
              );
            },
          ),
          SizedBox(height: 10),
          SizedBox(
            child: (response == '')
                ? null
                : Text(
                    response,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
