import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neushub/pages/app_bar.dart';

import 'package:neushub/bloc/sign_bloc.dart';

import '../theme.dart';
import '../icons.dart';
import '../widgets.dart';

class NeusHubSignDialog extends Dialog {
  const NeusHubSignDialog({super.key});

  NeusHubSignType signType(NeusHubSignState state) {
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
      child: BlocProvider<NeusHubSignBloc>(
        create: (context) => NeusHubSignBloc(),
        child: BlocBuilder<NeusHubSignBloc, NeusHubSignState>(
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
                                  BlocProvider.of<NeusHubSignBloc>(context).add(
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
                                  BlocProvider.of<NeusHubSignBloc>(context).add(
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
                  child: switch (signType(state)) {
                    NeusHubSignType.signUp => NeusHubSignUpPage(),
                    _ => NeusHubSignInPage(),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NeusHubSignInPage extends StatelessWidget {
  const NeusHubSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (MediaQuery.sizeOf(context).width < mobileSize.width + 100)
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 475,
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
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    TextSpan(text: 'Hub'),
                  ],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 44,
                    color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' dashboard you can track analytics of how your newsletter doing in our platform.',
                    ),
                  ],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                child: SizedBox(
                  width: 380,
                  child: Column(
                    children: [
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.email,
                      ),
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.password,
                      ),
                      SizedBox(height: 5),
                      NeusHubTextIconButton.filled(
                        icon: Icons.abc,
                        label: 'Sign in',
                        only: NeusHubTextIconOnly.textOnly,
                        expanded: true,
                        activated: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !(MediaQuery.sizeOf(context).width < mobileSize.width + 100),
          child: SizedBox(
            width: 400,
            child: Image.asset('assets/images/sign.png', fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}

class NeusHubSignUpPage extends StatelessWidget {
  const NeusHubSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (MediaQuery.sizeOf(context).width < mobileSize.width + 100)
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 475,
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
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    TextSpan(text: 'Hub'),
                  ],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 44,
                    color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' dashboard you can track analytics of how your newsletter doing in our platform.',
                    ),
                  ],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                child: SizedBox(
                  width: 380,
                  child: Column(
                    children: [
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.name,
                      ),
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.email,
                      ),
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.password,
                      ),
                      NeusHubTextIconField.filled(
                        fieldType: NeusHubTextIconFieldType.confirmPassword,
                      ),
                      SizedBox(height: 5),
                      NeusHubTextIconButton.filled(
                        icon: Icons.abc,
                        label: 'Sign up',
                        only: NeusHubTextIconOnly.textOnly,
                        expanded: true,
                        activated: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !(MediaQuery.sizeOf(context).width < mobileSize.width + 100),
          child: SizedBox(
            width: 400,
            child: Image.asset('assets/images/sign.png', fit: BoxFit.contain),
          ),
        ),
      ],
    );
    ;
  }
}
