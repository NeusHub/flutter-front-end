import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:neushub/pages/app_bar.dart';

import 'package:neushub/bloc/sign_bloc.dart';

import '../theme.dart';
import '../main.dart';

class NeusHubSignDialog extends Dialog {
  const NeusHubSignDialog({super.key});

  NeusHubSignType signType(NeusHubSignState state) {
    if (state is NeusHubSignChangedState) {
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
                              TextIconButtonJO(
                                icon: Icons.abc,
                                label: 'Log in?',
                                activated: true,
                                only: TextIconButtonOnlyJO.textOnly,
                                onPressed: () {
                                  BlocProvider.of<NeusHubSignBloc>(context)
                                      .add(NeusHubSignInEvent());
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
                              TextIconButtonJO(
                                icon: Icons.abc,
                                label: 'Apply now',
                                activated: true,
                                only: TextIconButtonOnlyJO.textOnly,
                                onPressed: () {
                                  BlocProvider.of<NeusHubSignBloc>(context)
                                      .add(NeusHubSignUpEvent());
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
      children: [
        Column(),
        Visibility(
          visible: !(MediaQuery.sizeOf(context).width < mobileSize.width),
          child: Image.asset('assets/images/sign.png'),
        ),
      ],
    );
  }
}

class NeusHubSignUpPage extends StatelessWidget {
  const NeusHubSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
