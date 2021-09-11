import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rental/core/helpers/get_image_url.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/core/presentation/txt_field.dart';
import 'package:rental/core/validators/InputFormValidators.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';

class UpdateProfile extends StatelessWidget with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();

  String? newProfilePath;
  final ImagePicker _picker = ImagePicker();

  late User user;

  late final nameTextController;
  late final emailTextController;
  late final phoneTextController;

  UpdateProfile(User user) {
    this.user = user;
    nameTextController = new TextEditingController(text: user.name);
    emailTextController = new TextEditingController(text: user.email);
    phoneTextController =
        new TextEditingController(text: user.phoneNumber ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Update Profile",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: LoaderOverlay(
          overlayOpacity: 0.8,
          child: SingleChildScrollView(
            child: Padding(
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
                    user = state.user;
                    this.nameTextController.text = user.name;
                    this.emailTextController.text = user.email;
                    this.phoneTextController.text = user.phoneNumber ?? "";

                    final lunchBar = LunchBars(
                        lunchBarText: "Profile Updated succesfully",
                        event: LunchBarEvents.LunchBarSuccess);
                    ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                  }
                },
                builder: (_, state) {
                  if (state is ProfileLoaded) {
                    user = state.user;

                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 135,
                              child: Stack(
                                children: [
                                  BlocConsumer<ProfileBloc, ProfileState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        if (state is ProfileLoaded &&
                                            state.changedProfilePath !=
                                                state.user.profileImage &&
                                            state.changedProfilePath != null) {
                                          newProfilePath =
                                              state.changedProfilePath;
                                          return ChangedProfile(
                                              profileURL:
                                                  state.changedProfilePath!);
                                        }
                                        // print(user.profileImage);
                                        return NetworkProfile(
                                            profileURL: getImageUrl(
                                                user.profileImage!));
                                      }),
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
                                                source: ImageSource.gallery);
                                        if (image != null) {
                                          // var updatedUser = state.user.copyWith(
                                          //     profileImage: image.path);
                                          profileBloc.add(ProfilePictureChange(
                                              user: user,
                                              changedProfilePath: image.path));
                                          // setState(() {
                                          //   newProfilePath = image.path;
                                          // });
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
                              if (this.isTextValid(name!)) {
                                return null;
                              }
                              return "Name can't be empty";
                            },
                          ),
                          TxtField(
                            label: "Email",
                            // initialValue: user.email,
                            controller: this.emailTextController,
                            validator: (email) {
                              if (this.isEmailValid(email!)) {
                                return null;
                              }
                              return "Invalid email address";
                            },
                          ),
                          TxtField(
                            label: "Phone",
                            // initialValue: user.phoneNumber,
                            controller: this.phoneTextController,
                            validator: (phoneNumber) {
                              if (this.isPhoneNumberValid(phoneNumber)) {
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
                                    // print("valid");
                                    profileBloc.add(ProfileUpdate(
                                        user: user.copyWith(
                                            name: this.nameTextController.text,
                                            email:
                                                this.emailTextController.text,
                                            phoneNumber:
                                                this.phoneTextController.text),
                                        changedProfilePath: newProfilePath));
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
                  return Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator()),
                  );
                },
              ),
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
