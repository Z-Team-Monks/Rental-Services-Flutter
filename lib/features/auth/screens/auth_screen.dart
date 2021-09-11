import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/admin/screens/admin_screen.dart';
import 'package:rental/features/auth/bloc/auth_form_bloc.dart';
import 'package:rental/features/auth/bloc/user_auth/user_auth_bloc.dart';
import 'package:rental/features/auth/screens/widgets/form_field.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
import 'package:rental/main.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class AuthPage extends StatefulWidget {
  final SolidController controller;
  static const pageRoute = "/auth";
  const AuthPage({Key? key, required this.controller}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final FocusNode usernameNode;
  late final FocusNode emailNode;
  late final FocusNode passwordNode;

  @override
  void initState() {
    this.usernameNode = FocusNode();
    this.emailNode = FocusNode();
    this.passwordNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    final authFormBloc = BlocProvider.of<AuthFormBloc>(context);
    final userAuthBloc = BlocProvider.of<UserAuthBloc>(context)
      ..add(UserStatusChecking());

    this.usernameNode
      ..addListener(() {
        if (!this.usernameNode.hasFocus) {
          context.read<AuthFormBloc>().add(UsernameUnfocused());
        }
      });
    this.emailNode
      ..addListener(() {
        if (!this.emailNode.hasFocus) {
          context.read<AuthFormBloc>().add(EmailUnfocused());
        }
      });
    this.passwordNode
      ..addListener(() {
        if (!this.passwordNode.hasFocus) {
          context.read<AuthFormBloc>().add(EmailUnfocused());
        }
      });

    return SafeArea(
        top: false,
        child: BlocConsumer<UserAuthBloc, UserAuthState>(
          listener: (context, state) {
            if (state == UserAuthState.LOGGEDIN_ADMIN) {
              Navigator.popAndPushNamed(context, AdminPage.pageRoute);
            } else if (state == UserAuthState.LOGGEDIN) {
              Navigator.popAndPushNamed(context, Home.pageRoute);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.srcOver),
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/content/house_bg.png"),
                )),
              ),
              bottomSheet: state == UserAuthState.CHECKING
                  ? LinearProgressIndicator()
                  : SolidBottomSheet(
                      controller: widget.controller,
                      maxHeight: 440,
                      draggableBody: true,
                      headerBar: Wrap(
                        children: [
                          GestureDetector(
                              onTap: () {
                                widget.controller.isOpened
                                    ? widget.controller.hide()
                                    : widget.controller.show();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: widget.controller.isOpened
                                        ? Icon(Icons.keyboard_arrow_down)
                                        : Icon(Icons.keyboard_arrow_up)),
                              )),
                        ],
                      ),
                      body: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        children: <Widget>[
                          signInPage(authFormBloc, userAuthBloc, this.emailNode,
                              this.passwordNode),
                          signUpPage(
                              authFormBloc,
                              userAuthBloc,
                              this.usernameNode,
                              this.emailNode,
                              this.passwordNode),
                        ],
                      ),
                    ),
            );
          },
        ));
  }
}

Widget signInPage(AuthFormBloc authFormBloc, UserAuthBloc userAuthBloc,
    FocusNode emailNode, FocusNode passwordNode) {
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          // color: Colors.green,
                          color: Color(0xff121515),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return CustomFormField(
                          obscure: false,
                          errorMessage: state.email.invalid
                              ? "Email format is incorrect"
                              : '',
                          label: 'example@rent.com',
                          onValueChange: (value) {
                            authFormBloc.add(EmailChanged(email: value));
                          });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return CustomFormField(
                          obscure: true,
                          errorMessage: state.password.invalid
                              ? 'password should be at least 6 character long\npassword must contain both letter and number'
                              : '',
                          label: 'Enter your password',
                          onValueChange: (value) {
                            authFormBloc.add(PasswordChanged(password: value));
                          });
                    },
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return (state.message != "" && state.message != null)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${state.message}",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 12)),
                              ],
                            )
                          : Container();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // TextButton(
                  //   style: ButtonStyle(
                  //       backgroundColor: MaterialStateColor.resolveWith(
                  //           (states) => Colors.transparent)),
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Forgot password",
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  // ),
                  Container(
                    width: double.infinity,
                    child: Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            passwordNode.unfocus();
                            emailNode.unfocus();
                            authFormBloc.add(LoginFormSubmitted());
                          },
                          child: BlocConsumer<AuthFormBloc, AuthFormState>(
                            listener: (ctx, state) {
                              if (state.status ==
                                  FormzStatus.submissionSuccess) {
                                userAuthBloc.add(UserStatusChecking());
                                // Navigator.of(ctx)
                                //     .pushReplacementNamed(HomeFeed.pageRoute);
                              }
                            },
                            builder: (context, state) {
                              return state.status ==
                                      FormzStatus.submissionInProgress
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.pinkAccent,
                                      ),
                                    );
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget signUpPage(AuthFormBloc authFormBloc, UserAuthBloc userAuthBloc,
    FocusNode usernameNode, FocusNode emailNode, FocusNode passwordNode) {
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          // color: Colors.green,
                          color: Color(0xff121515),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return CustomFormField(
                          obscure: false,
                          errorMessage: state.email.invalid
                              ? 'Please ensure username is not empty'
                              : '',
                          label: 'Enter your username',
                          onValueChange: (value) {
                            authFormBloc.add(UsernameChanged(username: value));
                          });
                    },
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return CustomFormField(
                          obscure: false,
                          errorMessage: state.email.invalid
                              ? "Email format is incorrect"
                              : '',
                          label: 'example@rent.com',
                          onValueChange: (value) {
                            authFormBloc.add(EmailChanged(email: value));
                          });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return CustomFormField(
                          obscure: true,
                          errorMessage: state.email.invalid
                              ? 'password should be at least 6 character long\npassword must contain both letter and number'
                              : '',
                          label: 'Enter your password',
                          onValueChange: (value) {
                            authFormBloc.add(PasswordChanged(password: value));
                          });
                    },
                  ),
                  BlocBuilder<AuthFormBloc, AuthFormState>(
                    builder: (context, state) {
                      return (state.message != "" && state.message != null)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${state.message}",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 12)),
                              ],
                            )
                          : Container();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            passwordNode.unfocus();
                            emailNode.unfocus();
                            usernameNode.unfocus();

                            authFormBloc.add(SignUpFormSubmitted());
                          },
                          child: BlocConsumer<AuthFormBloc, AuthFormState>(
                            listener: (ctx, state) {
                              if (state.status ==
                                  FormzStatus.submissionSuccess) {
                                userAuthBloc.add(UserStatusChecking());
                                // Navigator.of(ctx)
                                //     .pushReplacementNamed(HomeFeed.pageRoute);
                              }
                            },
                            builder: (context, state) {
                              return state.status ==
                                      FormzStatus.submissionInProgress
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Register",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.pinkAccent,
                                      ),
                                    );
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
