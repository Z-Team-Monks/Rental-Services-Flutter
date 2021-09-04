import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/core/presentation/txt_field.dart';
import 'package:rental/core/validators/InputFormValidators.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';

class UpdateProfile extends StatefulWidget with InputValidationMixin {
  // const UpdateProfile({Key? key}) : super(key: key);
  // final User user;
  @override
  final User user = new User(
      name: "Kidus",
      email: "se.kidus.yoseph@gmail.com",
      phoneNumber: "0972476097",
      profileImage:
          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80");
  State<UpdateProfile> createState() => _UpdateProfileState(user);
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  // final ImagePicker _picker = ImagePicker();
  String? newProfilePath;
  final ImagePicker _picker = ImagePicker();

  late User user;
  late final nameTextController;
  late final emailTextController;
  late final phoneTextController;

  _UpdateProfileState(User user) {
    this.user = user;
    nameTextController = new TextEditingController(text: user.name);
    emailTextController = new TextEditingController(text: user.email);
    phoneTextController = new TextEditingController(text: user.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LoaderOverlay(
          overlayOpacity: 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // LunchBar(lunchBarText: "We are having connecting"),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (_, state) {
                      if (state is ProfileUpdateFailure) {
                        final lunchBar = LunchBars(
                            lunchBarText: "Trouble connecting to the internet",
                            event: LunchBarEvents.LunchBarError);
                        ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                      }

                      if (state is ProfileUpdateSuccesful) {
                        final lunchBar = LunchBars(
                            lunchBarText: "Profile Updated succesfully",
                            event: LunchBarEvents.LunchBarSuccess);
                        ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                      }
                    },
                    builder: (_, state) {
                      if (state is ProfileLoaded) {
                        user = state.user;
                        nameTextController.text = user.name;
                        emailTextController.text = user.email;
                        phoneTextController.text = user.phoneNumber;

                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  height: 135,
                                  child: Stack(
                                    children: [
                                      ProfileIndicator(
                                          localURL: newProfilePath,
                                          remoteURL: user.profileImage!),
                                      Align(
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                          ),
                                          color: Colors.white,
                                          onPressed: () async {
                                            // Pick an image
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image != null) {
                                              setState(() {
                                                newProfilePath = image.path;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TxtField(
                                label: "Name",
                                // initialValue: user.name,
                                controller: nameTextController,
                                validator: (name) {
                                  if (widget.isNameValid(name!)) {
                                    return null;
                                  }
                                  return "Name can't be empty";
                                },
                              ),
                              TxtField(
                                label: "Email",
                                // initialValue: user.email,
                                controller: emailTextController,
                                validator: (email) {
                                  if (widget.isEmailValid(email!)) {
                                    return null;
                                  }
                                  return "Invalid email address";
                                },
                              ),
                              TxtField(
                                label: "Phone",
                                // initialValue: user.phoneNumber,
                                controller: phoneTextController,
                                validator: (phoneNumber) {
                                  if (widget
                                      .isPhoneNumberValid(phoneNumber ?? "")) {
                                    return null;
                                  }
                                  return "Invalid phone format";
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  width: size.width * 0.7,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        profileBloc.add(ProfileUpdate(
                                            user: user.copyWith(
                                                name: nameTextController.text,
                                                email: emailTextController.text,
                                                phoneNumber:
                                                    phoneTextController.text)));
                                      }
                                    },
                                    child: const Text(
                                      'Update',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileIndicator extends StatelessWidget {
  // const ProfileIndicator({Key? key}) : super(key: key);
  String? localURL;
  String remoteURL;

  ProfileIndicator({required this.localURL, required this.remoteURL});

  @override
  Widget build(BuildContext context) {
    if (localURL == null) {
      return NetworkProfile(profileURL: remoteURL);
    }
    return ChangedProfile(profileURL: localURL!);
  }
}

class NetworkProfile extends StatelessWidget {
  // const NetworkProfile({Key? key}) : super(key: key);
  String profileURL;

  NetworkProfile({required this.profileURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(profileURL),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChangedProfile extends StatelessWidget {
  String profileURL;
  ChangedProfile({required this.profileURL});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: ClipOval(child: Image.file(File(profileURL), fit: BoxFit.cover)),
      ),
    );
  }
}
