import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/features/auth/bloc/signin/signin_form_bloc.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/screens/widgets/form_field.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class LoginPage extends StatefulWidget {
  final SolidController controller;
  static const pageRoute = "/loginScreen";
  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final FocusNode emailNode;
  late final FocusNode passwordNode;

  @override
  void initState() {
    this.emailNode = FocusNode();
    this.passwordNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signInFormBloc = BlocProvider.of<SignInFormBloc>(context);
    this.emailNode
      ..addListener(() {
        if (!this.emailNode.hasFocus) {
          context.read<SignInFormBloc>().add(EmailUnfocused());
        }
      });
    this.passwordNode
      ..addListener(() {
        if (!this.passwordNode.hasFocus) {
          context.read<SignInFormBloc>().add(EmailUnfocused());
        }
      });
    return SolidBottomSheet(
      controller: SolidController(),
      maxHeight: 360,
      draggableBody: true,
      headerBar: Wrap(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 3,
              width: 150,
            ),
          ),
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
        ],
      ),
      body: SingleChildScrollView(
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
                        height: 25,
                      ),
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "YOUR EMAIL",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                      BlocBuilder<SignInFormBloc, SignInFormState>(
                        builder: (context, state) {
                          return CustomFormField(
                              errorMessage: state.email.invalid
                                  ? 'Please ensure email is not empty'
                                  : '',
                              label: 'example@niko.com',
                              onValueChange: (value) {
                                signInFormBloc.add(EmailChanged(email: value));
                              });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "YOUR PASSWORD",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      BlocBuilder<SignInFormBloc, SignInFormState>(
                        builder: (context, state) {
                          return CustomFormField(
                              errorMessage: state.email.invalid
                                  ? 'Please ensure password is not empty'
                                  : '',
                              label: 'Enter your password',
                              onValueChange: (value) {
                                signInFormBloc
                                    .add(PasswordChanged(password: value));
                              });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () {},
                        child: Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.black),
                        ),
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
                              signInFormBloc.add(FormSubmitted());
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
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
      ),
    );
  }

  // void registerTextFieldNodeListener() {

  // }
}
